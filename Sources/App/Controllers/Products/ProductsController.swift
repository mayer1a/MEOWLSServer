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

    let productsRepository: ProductsRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {

        let products = routes.grouped("api", "v1", "products")

        products.get("", use: getProducts)
        products.get(":product_id", use: getProduct)
    }

    @Sendable func getProducts(_ request: Request) async throws -> PaginationResponse<ProductDTO> {

        let page = try request.query.decode(PageRequest.self)

        if let categoryID: UUID = request.query[categoryQuery] {

            return try await productsRepository.getProducts(categoryID: categoryID, with: page)

        } else if let saleID: UUID = request.query[saleQuery] {

            return try await productsRepository.getProducts(saleID: saleID, with: page)
        }

        throw Abort(.badRequest)
    }

    @Sendable func getProduct(_ request: Request) async throws -> ProductDTO {

        guard let productID = request.parameters.get("product_id", as: UUID.self) else {
            throw Abort(.badRequest)
        }

        return try await productsRepository.getDTO(for: productID)
    }

}
