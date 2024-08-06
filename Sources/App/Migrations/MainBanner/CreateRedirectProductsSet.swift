//
//  CreateRedirectProductsSet.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateRedirectProductsSet: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("main_banners_products_sets")
            .id()
            .field("redirect_id", .uuid, .required, .references("main_banners_redirects", "id", onDelete: .cascade))
            .field("name", .string, .required)
            .field("category_id", .uuid, .references("categories", "id", onDelete: .cascade))
            .field("query", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("main_banners_products_sets").delete()
    }

}
