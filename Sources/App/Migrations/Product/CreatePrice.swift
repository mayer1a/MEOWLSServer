//
//  CreatePrice.swift
//  
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreatePrice: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("prices")
            .id()
            .field("product_variant_id", .uuid, .references("product_variants", "id", onDelete: .cascade))
            .field("cart_item_id", .uuid, .references("cart_items", "id", onDelete: .cascade))
            .field("original_price", .double, .required)
            .field("discount", .double)
            .field("price", .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("prices").delete()
    }

}
