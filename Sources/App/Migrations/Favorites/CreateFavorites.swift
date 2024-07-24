//
//  CreateFavorites.swift
//  
//
//  Created by Artem Mayer on 24.07.2024.
//

import Fluent

struct CreateFavorites: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("favorites")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("favorites").delete()
    }

}
