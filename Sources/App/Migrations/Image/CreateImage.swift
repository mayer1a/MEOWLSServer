//
//  CreateImage.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateImage: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("images")
            .id()
            .field("category_id", .uuid, .references("categories", "id", onDelete: .cascade))
            .field("small", .string)
            .field("medium", .string)
            .field("large", .string)
            .field("original", .string)
            .field("main_banner_id", .uuid, .references("main_banners", "id", onDelete: .cascade))
            .field("sale_id", .uuid, .references("sales", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("images").delete()
    }

}
