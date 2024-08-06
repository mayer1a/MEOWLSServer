//
//  CategoryController.swift
//
//
//  Created by Artem Mayer on 03.08.2024.
//

import Vapor
import Fluent

struct CategoryController: RouteCollection {

    private let categoryQuery = "category_id"

    let categoryRepository: CategoryRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {

        let categories = routes.grouped("api", "v1", "categories")

        categories.get("", use: get)
    }


    @Sendable func get(_ request: Request) async throws -> [CategoryDTO] {

        guard let categoryID: UUID = request.query[categoryQuery] else {
            throw Abort(.badRequest)
        }

        return try await categoryRepository.get(for: categoryID)
    }

}
