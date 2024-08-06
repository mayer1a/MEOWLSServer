//
//  CreatePromoCodesProductsPivot.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Fluent

struct CreatePromoCodesProductsPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("promo_codes+products")
            .id()
            .field("promo_code_id", .uuid, .required, .references("promo_codes", "id", onDelete: .cascade))
            .field("product_id", .uuid, .required, .references("products", "id", onDelete: .cascade))
            .unique(on: "promo_code_id", "product_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("promo_codes+products").delete()
    }

}
