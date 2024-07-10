//
//  TokenMigration.swift
//  
//
//  Created by Artem Mayer on 21.06.2024.
//

import Vapor
import Fluent

struct TokenMigration: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("tokens")
            .id()
            .field("value", .string, .required)
            .field("expired", .date)
            .field("userID", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tokens").delete()
    }

}
