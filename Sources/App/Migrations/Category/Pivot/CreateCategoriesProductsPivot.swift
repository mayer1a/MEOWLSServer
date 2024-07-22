//
//  CreateCategoriesProductsPivot.swift
//  
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateCategoriesProductsPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("categories+products")
            .id()
            .field("product_id", .uuid, .required,
                   .references("products", "id", onDelete: .cascade))
            .field("category_id", .uuid, .required,
                   .references("categories", "id", onDelete: .cascade))
            .unique(on: "product_id", "category_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("categories+products").delete()
    }

}
