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
            .field("product_variant_id", .uuid, .required, .references("product_variants", "id", onDelete: .cascade))
            .field("originalPrice", .double, .required)
            .field("discount", .double)
            .field("price", .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("prices").delete()
    }

}
