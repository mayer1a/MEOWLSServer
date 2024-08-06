//
//  CreateToken.swift
//  
//
//  Created by Artem Mayer on 21.06.2024.
//

import Fluent

struct CreateToken: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("tokens")
            .id()
            .field("value", .string, .required)
            .field("expired", .date)
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .unique(on: "value")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tokens").delete()
    }

}
