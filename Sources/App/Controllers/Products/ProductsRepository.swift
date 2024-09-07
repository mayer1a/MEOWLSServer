//
//  ProductsRepository.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

protocol ProductsRepositoryProtocol: Sendable {

    func getProducts(categoryID: UUID, with page: PageRequest) async throws -> PaginationResponse<ProductDTO>
    func getProducts(saleID: UUID, with page: PageRequest) async throws -> PaginationResponse<ProductDTO>
    func get(for productID: UUID) async throws -> Product
    func getDTO(for productID: UUID) async throws -> ProductDTO
    func getFilters(for categoryID: UUID) async throws -> [FilterDTO]

}

final class ProductsRepository: ProductsRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func getProducts(categoryID: UUID, with page: PageRequest) async throws -> PaginationResponse<ProductDTO> {
        let paginationPoducts = try await eagerLoadRelations(categoryID: categoryID, page)
        let productsDTOs = try DTOFactory.makeProducts(from: paginationPoducts.results) ?? []

        return PaginationResponse(results: productsDTOs, paginationInfo: paginationPoducts.paginationInfo)
    }

    func getProducts(saleID: UUID, with page: PageRequest) async throws -> PaginationResponse<ProductDTO> {
        let paginationPoducts = try await eagerLoadRelations(saleID: saleID, page)
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

    func getFilters(for categoryID: UUID) async throws -> [FilterDTO] {
        guard
            let category = try await Category.find(categoryID, on: database),
            let categoriesIDs = try? await getCategoriesIDs(for: category)
        else {
            throw ErrorFactory.internalError(.fetchFiltersForCategoryError, failures: [.ID(categoryID)])
        }

        let sqlDatabase = database as! SQLDatabase

        let filterCountsQuery = try await sqlDatabase.raw(getRawSQL(for: categoriesIDs))
            .all(decoding: FilterDBResponse.self)

        return try DTOFactory.makeFilters(from: filterCountsQuery)
    }

    private func eagerLoadRelations(categoryID: UUID, 
                                    _ page: PageRequest) async throws -> PaginationResponse<Product> {

        guard 
            let category = try await Category.find(categoryID, on: database),
            let categoriesIDs = try? await getCategoriesIDs(for: category),
            let paginationPoducts = try await eagerLoadProducts(saleID: nil, categoriesIDs: categoriesIDs, with: page)
        else {
            throw ErrorFactory.internalError(.fetchProductsForCategoryError, failures: [.ID(categoryID)])
        }

        return paginationPoducts
    }

    private func eagerLoadRelations(saleID: UUID, _ page: PageRequest) async throws -> PaginationResponse<Product> {
        guard
            let saleID = try await Sale.find(saleID, on: database)?.requireID(),
            let paginationPoducts = try await eagerLoadProducts(saleID: saleID, categoriesIDs: nil, with: page)
        else {
            throw ErrorFactory.internalError(.fetchProductsForSaleError, failures: [.ID(saleID)])
        }

        return paginationPoducts
    }

    private func eagerLoadProducts(saleID: UUID?,
                                   categoriesIDs: [UUID]?,
                                   with page: PageRequest) async throws -> PaginationResponse<Product>? {


        var productsQuery = Product.query(on: database)

        if let saleID {
            productsQuery = productsQuery.filter(\.$sale.$id == saleID)
        } else if let categoriesIDs {
            productsQuery = productsQuery
                .join(siblings: \.$categories)
                .filter(Category.self, \.$id ~~ categoriesIDs)
        } else {
            return nil
        }

        productsQuery = productsQuery
            .with(\.$images)
            .with(\.$variants) { variant in
                variant
                    .with(\.$price)
                    .with(\.$availabilityInfo)
                    .with(\.$badges)
            }

        return try await productsQuery.paginate(with: page)
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

    private func getRawSQL(for categoriesIDs: [UUID]) -> SQLQueryString {
        """
        SELECT
            P_PROPERTY.CODE AS PROPERTY_CODE,
            P_PROPERTY.NAME AS PROPERTY_NAME,
            P_VALUE.VALUE AS PROPERTY_VALUE,
            COUNT(DISTINCT P.ID) AS COUNT
        FROM
            PROPERTY_VALUES P_VALUE
            JOIN "product_variants+property_values" PVPV ON P_VALUE.ID = PVPV.PROPERTY_VALUE_ID
            JOIN PRODUCT_VARIANTS PV ON PVPV.PRODUCT_VARIANT_ID = PV.ID
            JOIN PRODUCTS P ON PV.PRODUCT_ID = P.ID
            JOIN "categories+products" CPP ON P.ID = CPP.PRODUCT_ID
            JOIN PRODUCT_PROPERTIES P_PROPERTY ON P_VALUE.PRODUCT_PROPERTY_ID = P_PROPERTY.ID
        WHERE
            CPP.CATEGORY_ID IN (\(unsafeRaw: categoriesIDs.map { "'\($0.uuidString)'" }.joined(separator: ",")))
        GROUP BY
            P_PROPERTY.CODE,
            P_PROPERTY.NAME,
            P_VALUE.VALUE
        """
    }

}
