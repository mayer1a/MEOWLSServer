//
//  ProductsController.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

struct ProductsController: RouteCollection {

    private let categoryQuery = "category_id"
    private let saleQuery = "sale_id"
    private let idsQuery = "products_ids"
    private let idParameter = "product_id"

    let productsRepository: ProductsRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("api", "v1", "products")
        let filters = routes.grouped("api", "v1", "filters")

        products.get("", use: getProducts)
        products.get(":\(idParameter)", use: getProduct)

        filters.get("", use: getFilters)
    }

    @Sendable func getProducts(_ request: Request) async throws -> PaginationResponse<ProductDTO> {

        let page = try request.query.decode(PageRequest.self)
        let filters = try? request.query.decode(FilterQueryRequest.self)

        if let categoryID: UUID = request.query[categoryQuery] {

            return try await productsRepository.getProducts(categoryID: categoryID, with: page, filters: filters)

        } else if let saleID: UUID = request.query[saleQuery] {

            return try await productsRepository.getProducts(saleID: saleID, with: page, filters: filters)

        } else if let productsIDs: String = request.query[idsQuery] {

            let productsIDs = productsIDs.components(separatedBy: ",")
            return try await productsRepository.getProducts(by: productsIDs, with: page)
        }

        throw ErrorFactory.badRequest(.categoryIDOrProductsIDsRequired)
    }

    @Sendable func getProduct(_ request: Request) async throws -> ProductDTO {
        guard let productID = request.parameters.get(idParameter, as: UUID.self) else {
            throw ErrorFactory.badRequest(.productIdRequired)
        }

        return try await productsRepository.getDTO(for: productID)
    }

    @Sendable func getFilters(_ request: Request) async throws -> [FilterDTO] {
        guard let categoryID: UUID = request.query[categoryQuery] else {
            throw ErrorFactory.badRequest(.categoryIDRequired)
        }

        let filters = try? request.query.decode(FilterQueryRequest.self)

        return try await productsRepository.getFilters(for: categoryID, filters: filters)
    }

}
