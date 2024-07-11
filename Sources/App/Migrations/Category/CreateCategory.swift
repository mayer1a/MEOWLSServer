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
            .field("parent_id", .uuid, .references("categories", "id", onDelete: .cascade))
            .field("count", .int, .required)
            .field("childCategories", .array(of: .string), .required)
            .unique(on: "code")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }

}
