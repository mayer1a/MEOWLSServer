//
//  CreateProduct.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateProduct: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("products")
            .id()
            .field("name", .string, .required)
            .field("code", .string, .required)
            .field("allow_quick_buy", .bool, .required)
            .field("default_variant_article", .string)
            .field("delivery_conditions_url", .string)
            .unique(on: "code")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("products").delete()
    }

}
