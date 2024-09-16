//
//  CreateLocation.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateLocation: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("locations")
            .id()
            .field("address_id", .uuid, .references("addresses", "id", onDelete: .cascade))
            .field("city_id", .uuid, .references("cities", "id", onDelete: .cascade))
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .unique(on: "address_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("locations").delete()
    }

}
