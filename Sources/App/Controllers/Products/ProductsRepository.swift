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
    func get(for productID: UUID) async throws -> Product?
    func getDTO(for productID: UUID) async throws -> ProductDTO

}

final class ProductsRepository: ProductsRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func getProducts(categoryID: UUID, with page: PageRequest) async throws -> PaginationResponse<ProductDTO> {

        guard let paginationPoducts = try await eagerLoadRelations(categoryID: categoryID, page) else {
            throw ErrorFactory.internalError(.fetchProductsForCategoryError, failures: [.ID(categoryID)])
        }

        let productsDTOs = try DTOFactory.makeProducts(from: paginationPoducts.results) ?? []

        return PaginationResponse(results: productsDTOs, paginationInfo: paginationPoducts.paginationInfo)
    }

    func getProducts(saleID: UUID, with page: PageRequest) async throws -> PaginationResponse<ProductDTO> {

        guard let paginationPoducts = try await eagerLoadRelations(saleID: saleID, page) else {
            throw ErrorFactory.internalError(.fetchProductsForSaleError, failures: [.ID(saleID)])
        }

        let productsDTOs = try DTOFactory.makeProducts(from: paginationPoducts.results) ?? []

        return PaginationResponse(results: productsDTOs, paginationInfo: paginationPoducts.paginationInfo)
    }

    func get(for productID: UUID) async throws -> Product? {

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

        let product = try await Product.query(on: database)
            .filter(\.$id == productID)
            .with(\.$images)
            .with(\.$variants) { variant in
                variant
                    .with(\.$price)
                    .with(\.$availabilityInfo)
                    .with(\.$badges)
                    .with(\.$propertyValues) { propertyValue in
                        propertyValue.with(\.$productProperty)
                    }
            }
            .with(\.$sections)
            .first()

        guard let product else { throw ErrorFactory.internalError(.fetchProductByIdError, failures: [.ID(productID)]) }

        return try DTOFactory.makeProduct(from: product)
    }

    private func eagerLoadRelations(categoryID: UUID, 
                                    _ page: PageRequest) async throws -> PaginationResponse<Product>? {

        guard let category = try await Category.find(categoryID, on: database) else { return nil }

        let categoriesIDs = try await getCategoriesIDs(for: category)

        let products = try await Product.query(on: database)
            .join(siblings: \.$categories)
            .filter(Category.self, \.$id ~~ categoriesIDs)
            .with(\.$images)
            .with(\.$variants) { variant in
                variant
                    .with(\.$price)
                    .with(\.$availabilityInfo)
                    .with(\.$badges)
            }
            .paginate(with: page)

        return products
    }

    private func eagerLoadRelations(saleID: UUID, _ page: PageRequest) async throws -> PaginationResponse<Product>? {

        guard let saleID = try await Sale.find(saleID, on: database)?.requireID() else { return nil }

        let products = try await Product.query(on: database)
            .filter(\.$sale.$id == saleID)
            .with(\.$images)
            .with(\.$variants) { variant in
                variant
                    .with(\.$price)
                    .with(\.$availabilityInfo)
                    .with(\.$badges)
            }
            .paginate(with: page)

        return products
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

}
