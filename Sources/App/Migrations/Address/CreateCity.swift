//
//  CreateCity.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateCity: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("cities")
            .id()
            .field("address_id", .uuid, .required, .references("addresses", "id", onDelete: .cascade))
            .field("name", .string, .required)
            .field("fias_id", .string, .required)
            .unique(on: "address_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("cities").delete()
    }

}
