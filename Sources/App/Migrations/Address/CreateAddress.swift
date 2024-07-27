//
//  CreateAddress.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateAddress: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("addresses")
            .id()
            .field("delivery_id", .uuid, .references("deliveries", "id", onDelete: .cascade))
            .field("user_id", .uuid, .references("users", "id", onDelete: .cascade))
            .field("street", .string, .required)
            .field("house", .string, .required)
            .field("entrance", .string)
            .field("floor", .string)
            .field("flat", .string)
            .field("formatted_string", .string, .required)
            .unique(on: "delivery_id", "user_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("addresses").delete()
    }

}
