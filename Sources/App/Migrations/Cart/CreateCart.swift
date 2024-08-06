//
//  CreateCart.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateCart: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("carts")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .unique(on: "user_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("carts").delete()
    }

}
