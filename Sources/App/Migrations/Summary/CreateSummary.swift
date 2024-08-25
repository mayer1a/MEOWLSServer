//
//  CreateSummary.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateSummary: AsyncMigration {

    func prepare(on database: Database) async throws {
        let summaryType = try await database.enum("SummaryType").read()

        try await database.schema("summaries")
            .id()
            .field("cart_id", .uuid, .references("carts", "id", onDelete: .cascade))
            .field("order_id", .uuid, .references("orders", "id", onDelete: .cascade))
            .field("name", .string, .required)
            .field("value", .double, .required)
            .field("type", summaryType, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("summaries").delete()
    }

}
