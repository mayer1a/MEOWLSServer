//
//  CreateFavoritesProductsPivot.swift
//  
//
//  Created by Artem Mayer on 24.07.2024.
//

import Fluent

struct CreateFavoritesProductsPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("favorites+products")
            .id()
            .field("product_id", .uuid, .required,
                   .references("products", "id", onDelete: .cascade))
            .field("favorites_id", .uuid, .required,
                   .references("favorites", "id", onDelete: .cascade))
            .unique(on: "product_id", "favorites_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("favorites+products").delete()
    }

}
