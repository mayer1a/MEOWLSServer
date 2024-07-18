//
//  CreateCategory.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateCategory: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("categories")
            .id()
            .field("code", .string, .required)
            .field("name", .string, .required)
            .field("parent_id", .uuid, .references("categories", "id", onDelete: .cascade))
            .unique(on: "parent_id", "code")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }

}
