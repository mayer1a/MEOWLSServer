//
//  CreateProductVariantBadgePivot.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Fluent

struct CreateProductVariantBadgePivot: AsyncMigration {

    func prepare(on database: Database) async throws {

        try await database.schema("product_variants+badges")
            .id()
            .field("product_variant_id", .uuid, .required, .references("product_variants", "id", onDelete: .cascade))
            .field("badge_id", .uuid, .required, .references("badges", "id", onDelete: .cascade))
            .unique(on: "product_variant_id", "badge_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("product_variants+badges").delete()
    }

}
