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
            .field("main_banner_id", .uuid, .references("main_banners", "id", onDelete: .setNull))
            .unique(on: "parent_id", "code")
            .create()
                .field("has_children", .bool, .required, .sql(.default(SQLLiteral.boolean(false))))
    }

    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }

}
