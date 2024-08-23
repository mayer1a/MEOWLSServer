//
//  CategoryRepository.swift
//
//
//  Created by Artem Mayer on 03.08.2024.
//

import Vapor
import Fluent

protocol CategoryRepositoryProtocol: Sendable {

    func get(for categoryID: UUID) async throws -> [CategoryDTO]

}

final class CategoryRepository: CategoryRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func add(_ user: User) async throws {
        let favorites = Favorites(userID: try user.requireID())
        try await favorites.save(on: database)
    }

    func get(for categoryID: UUID) async throws -> [CategoryDTO] {

        let categories = try await Category.query(on: database)
            .filter(\.$parent.$id == categoryID)
            .with(\.$parent, { parent in
                parent.with(\.$image)
            })
            .with(\.$image)
            .all()

        return try await categories.asyncMap { category in

            guard let categoryDTO = try DTOBuilder.makeCategory(from: category, fullModel: true) else {
                throw ErrorFactory.internalError(.fetchCategoryError, failures: [.ID(category.id)])
            }
            return categoryDTO
        }
    }

}
