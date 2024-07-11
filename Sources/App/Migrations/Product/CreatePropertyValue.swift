//
//  CreatePropertyValue.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Fluent

struct CreatePropertyValue: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("property_values")
            .id()
            .field("value", .string, .required)
            .field("product_id", .uuid, .references("products", "id"))
            .field("product_property_id", .uuid, .required, .references("product_properties", "id", onDelete: .cascade))
            .unique(on: "value")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("property_values").delete()
    }

}
