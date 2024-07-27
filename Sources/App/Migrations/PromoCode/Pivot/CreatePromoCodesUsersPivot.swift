//
//  CreatePromoCodesUsersPivot.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Fluent

struct CreatePromoCodesUsersPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("promo_codes+users")
            .id()
            .field("promo_code_id", .uuid, .required,
                   .references("promo_codes", "id", onDelete: .cascade))
            .field("user_id", .uuid, .required,
                   .references("users", "id", onDelete: .cascade))
            .unique(on: "promo_code_id", "user_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("promo_codes+users").delete()
    }

}
