//
//  CreateRegion.swift
//
//
//  Created by Artem Mayer on 08.08.2024.
//

import Fluent

struct CreateRegion: AsyncMigration {

    func prepare(on database: Database) async throws {

        try await database.schema("regions")
            .id()
            .field("name", .string, .required)
            .unique(on: "name")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("regions").delete()
    }

}
