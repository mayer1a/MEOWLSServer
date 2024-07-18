//
//  CreateProductVariantsPropertyValuesPivot.swift
//  
//
//  Created by Artem Mayer on 17.07.2024.
//

import Fluent

struct CreateProductVariantsPropertyValuesPivot: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("product_variants+property_values")
            .id()
            .field("product_variant_id", .uuid, .required,
                   .references("product_variants", "id", onDelete: .cascade))
            .field("property_value_id", .uuid, .required,
                   .references("property_values", "id", onDelete: .cascade))
            .unique(on: "product_variant_id", "property_value_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("product_variants+property_values").delete()
    }

}
