//
//  ProductsRepository.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent
import FluentSQL

protocol ProductsRepositoryProtocol: Sendable {

    func getProducts(categoryID: UUID,
                     with page: PageRequest,
                     filters: FilterQueryRequest?) async throws -> PaginationResponse<ProductDTO>

    func getProducts(saleID: UUID,
                     with page: PageRequest,
                     filters: FilterQueryRequest?) async throws -> PaginationResponse<ProductDTO>

    func getProducts(by productsIDs: [String], with page: PageRequest) async throws -> PaginationResponse<ProductDTO>

    func get(for productID: UUID) async throws -> Product
    func getDTO(for productID: UUID) async throws -> ProductDTO
    func getFilters(for categoryID: UUID, filters: FilterQueryRequest?) async throws -> [FilterDTO]

}

final class ProductsRepository: ProductsRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func getProducts(categoryID: UUID,
                     with page: PageRequest,
                     filters: FilterQueryRequest?) async throws -> PaginationResponse<ProductDTO> {

        let paginationPoducts = try await eagerLoadRelations(categoryID: categoryID, page, filters: filters)
        let productsDTOs = try DTOFactory.makeProducts(from: paginationPoducts.results) ?? []

        return PaginationResponse(results: productsDTOs, paginationInfo: paginationPoducts.paginationInfo)
    }

    func getProducts(saleID: UUID,
                     with page: PageRequest,
                     filters: FilterQueryRequest?) async throws -> PaginationResponse<ProductDTO> {

        let paginationPoducts = try await eagerLoadRelations(saleID: saleID, page)
        let productsDTOs = try DTOFactory.makeProducts(from: paginationPoducts.results) ?? []

        return PaginationResponse(results: productsDTOs, paginationInfo: paginationPoducts.paginationInfo)
    }

    func getProducts(by productsIDs: [String], with page: PageRequest) async throws -> PaginationResponse<ProductDTO> {
        let productsUUIDs = productsIDs.compactMap { $0.toUUID }
        let paginationPoducts = try await eagerLoadRelations(productsIDs: productsUUIDs, page)
        let productsDTOs = try DTOFactory.makeProducts(from: paginationPoducts.results) ?? []

        return PaginationResponse(results: productsDTOs, paginationInfo: paginationPoducts.paginationInfo)
    }

    func get(for productID: UUID) async throws -> Product {
        let product = try await Product.query(on: database)
            .filter(\.$id == productID)
            .with(\.$images)
            .with(\.$variants, { variant in
                variant
                    .with(\.$price)
                    .with(\.$availabilityInfo)
                    .with(\.$badges)
                    .with(\.$propertyValues) { propertyValue in
                        propertyValue.with(\.$productProperty)
                    }
            })
            .with(\.$sections)
            .first()

        guard let product else { throw ErrorFactory.internalError(.fetchProductByIdError, failures: [.ID(productID)]) }

        return product
    }

    func getDTO(for productID: UUID) async throws -> ProductDTO {
        let product = try await get(for: productID)
        return try DTOFactory.makeProduct(from: product)
    }

    func getFilters(for categoryID: UUID, filters: FilterQueryRequest?) async throws -> [FilterDTO] {
        guard
            let category = try await Category.find(categoryID, on: database),
            let categoriesIDs = try? await getCategoriesIDs(for: category)
        else {
            throw ErrorFactory.internalError(.fetchFiltersForCategoryError, failures: [.ID(categoryID)])
        }

        guard let filters = filters?.filters, let sqlDatabase = database as? SQLDatabase else {
            return []
        }

        let availableFiltersRawSQL = FiltersSQLRawFactory.makeAvailableFiltersSQL(for: categoriesIDs, filters: filters)
        let filterCountsQuery = try await sqlDatabase.raw(availableFiltersRawSQL)
            .all(decoding: FilterDBResponse.self)

        return try DTOFactory.makeFilters(from: filterCountsQuery)
    }

    private func eagerLoadRelations(categoryID: UUID,
                                    _ page: PageRequest,
                                    filters: FilterQueryRequest?) async throws -> PaginationResponse<Product> {
        guard
            let category = try await Category.find(categoryID, on: database),
            let categoriesIDs = try? await getCategoriesIDs(for: category),
            let products = try await eagerLoadProducts(categoriesIDs: categoriesIDs, filters: filters, with: page)
        else {
            throw ErrorFactory.internalError(.fetchProductsForCategoryError, failures: [.ID(categoryID)])
        }

        return products
    }

    private func eagerLoadRelations(saleID: UUID, _ page: PageRequest) async throws -> PaginationResponse<Product> {
        guard
            let saleID = try await Sale.find(saleID, on: database)?.requireID(),
            let products = try await eagerLoadProducts(saleID: saleID, with: page)
        else {
            throw ErrorFactory.internalError(.fetchProductsForSaleError, failures: [.ID(saleID)])
        }
        
        return products
    }

    private func eagerLoadRelations(productsIDs: [UUID], _ page: PageRequest) async throws -> PaginationResponse<Product> {
        guard
            let products = try await eagerLoadProducts(productsIDs: productsIDs, with: page)
        else {
            throw ErrorFactory.internalError(.fetchProductByIdError, failures: [.IDs(productsIDs)])
        }

        return products
    }

    private func eagerLoadProducts(saleID: UUID? = nil,
                                   categoriesIDs: [UUID]? = nil,
                                   productsIDs: [UUID]? = nil,
                                   filters: FilterQueryRequest? = nil,
                                   with page: PageRequest) async throws -> PaginationResponse<Product>? {

        var query: QueryBuilder<Product>?
        if let filters {
            let productsIDs = try await getFilteredProducts(for: categoriesIDs, filters: filters)
            query = getFilteredProductsQuery(saleID: saleID, categoriesIDs: categoriesIDs, productsIDs: productsIDs)

            if let sort = filters.sort {
                query = addSort(sort, to: query)
            }
        } else {
            query = getFilteredProductsQuery(saleID: saleID, categoriesIDs: categoriesIDs, productsIDs: productsIDs)
        }

        return try await query?.paginate(with: page)
    }

    private func addSort(_ sort: FiltersSort, to query: QueryBuilder<Product>?) -> QueryBuilder<Product>? {
        switch sort {
        case .priceAsc, .priceDesc: 
            query?
                .join(ProductVariant.self,
                      on: \Product.$id == \ProductVariant.$product.$id
                      && \ProductVariant.$article == \Product.$defaultVariantArticle)
                .join(Price.self, on: \ProductVariant.$id == \Price.$productVariant.$id)
                .sort(Price.self, \.$price, sort.direction)

        case .nameAsc, .nameDesc:
            query?.sort(\Product.$name, sort.direction)

        case .index:
            break

        }

        return query
    }

    private func getFilteredProductsQuery(saleID: UUID? = nil,
                                          categoriesIDs: [UUID]?,
                                          productsIDs: [UUID]?) -> QueryBuilder<Product>? {

        let productsQuery = Product.query(on: database)

        if let saleID {
            productsQuery.filter(\.$sale.$id == saleID)
        } else if let productsIDs {
            productsQuery
                .filter(\.$id ~~ productsIDs)
        } else if let categoriesIDs {
            productsQuery
                .join(siblings: \.$categories)
                .filter(Category.self, \.$id ~~ categoriesIDs)
        } else {
            return nil
        }

        return productsQuery
            .with(\.$images)
            .with(\.$variants) { variant in
                variant
                    .with(\.$price)
                    .with(\.$availabilityInfo)
                    .with(\.$badges)
            }
    }

    private func getCategoriesIDs(for category: Category) async throws -> [UUID] {
        guard category.hasChildren else { return [try category.requireID()] }

        let childCategories = try await Category.query(on: database)
            .filter(\.$parent.$id == category.requireID())
            .all()

        var result: [UUID] = []
        
        try await childCategories.asyncForEach { childCategory in
            result.append(contentsOf: try await getCategoriesIDs(for: childCategory))
        }

        return result
    }

    private func getFilteredProducts(for categoriesIDs: [UUID]?, filters: FilterQueryRequest?) async throws -> [UUID]? {
        guard filters?.filters != nil || filters?.sort != nil else { return nil }

        let rawBuilder = FilteredProductsBuilder()

        if let categoriesIDs {
            rawBuilder.setCategoriesWhereCondition(for: categoriesIDs)
        }

        if let filters = filters?.filters {
            rawBuilder.setFiltersWhereCondition(for: filters)
        }

        guard let rawSQL = rawBuilder.build(), let sqlDatabase = database as? SQLDatabase else {
            return nil
        }

        return try? await sqlDatabase.raw(rawSQL)
            .all(decodingFluent: Product.self)
            .map({ try  $0.requireID() })
    }

}
