//
//  CreateCartItem.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateCartItem: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("cart_items")
            .id()
            .field("product_id", .uuid, .required, .references("products", "id", onDelete: .cascade))
            .field("cart_id", .uuid, .references("carts", "id", onDelete: .cascade))
            .field("order_id", .uuid, .references("orders", "id", onDelete: .cascade))
            .field("article", .string, .required)
            .field("count", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("cart_items").delete()
    }

}
