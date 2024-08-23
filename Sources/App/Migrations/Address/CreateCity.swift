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
            .field("region_id", .uuid, .required, .references("regions", "id", onDelete: .cascade))
            .field("name", .string, .required)
            .field("city_time_zone", .string, .required)
            .unique(on: "name")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("cities").delete()
    }

}
