//
//  CreateProductVariant.swift
//  
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateProductVariant: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("product_variants")
            .id()
            .field("product_id", .uuid, .required, .references("products", "id", onDelete: .cascade))
            .field("article", .string, .required)
            .field("short_name", .string, .required)
            .unique(on: "product_id", "article", "short_name")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("product_variants").delete()
    }

}
