//
//  CreateProductProperty.swift
//  
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateProductProperty: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("product_properties")
            .id()
            .field("product_id", .uuid, .required, .references("products", "id", onDelete: .cascade))
            .field("name", .string, .required)
            .field("code", .string, .required)
            .field("selectable", .bool, .required)
            .unique(on: "product_id", "name", "code")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("product_properties").delete()
    }

}
