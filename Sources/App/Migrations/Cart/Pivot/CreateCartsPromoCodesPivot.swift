//
//  CreateCartsPromoCodesPivot.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateCartsPromoCodesPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("carts+promo_codes")
            .id()
            .field("cart_id", .uuid, .required,.references("carts", "id", onDelete: .cascade))
            .field("promo_code_id", .uuid, .required,.references("promo_codes", "id", onDelete: .cascade))
            .unique(on: "cart_id", "promo_code_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("carts+promo_codes").delete()
    }

}
