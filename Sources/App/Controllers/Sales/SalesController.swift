//
//  SalesController.swift
//  
//
//  Created by Artem Mayer on 05.08.2024.
//

import Vapor
import Fluent

struct SalesController: RouteCollection {

    private let saleTypeQuery = "sale_type"

    let salesRepository: SalesRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {

        let sales = routes.grouped("api", "v1", "sales")

        sales.get("", use: get)
    }

    @Sendable func get(_ request: Request) async throws -> PaginationResponse<SaleDTO> {

        let saleType: SaleType = request.query[saleTypeQuery] ?? .online
        let page = try request.query.decode(PageRequest.self)

        return try await salesRepository.get(for: saleType, with: page)
    }

}
