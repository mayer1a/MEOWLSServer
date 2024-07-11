//
//  CreateProductImagesPivot.swift
//  
//
//  Created by Artem Mayer on 10.07.2024.
//

import Fluent

struct CreateProductImagesPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("products+images")
            .id()
            .field("product_id", .uuid, .required,
                   .references("products", "id", onDelete: .cascade))
            .field("image_id", .uuid, .required,
                   .references("images", "id", onDelete: .cascade))
            .unique(on: "product_id", "image_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("products+images").delete()
    }

}
