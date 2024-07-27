//
//  CreateSummary.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateSummary: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("summaries")
            .id()
            .field("cart_id", .uuid, .references("carts", "id", onDelete: .cascade))
            .field("name", .string, .required)
            .field("value", .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("summaries").delete()
    }

}
