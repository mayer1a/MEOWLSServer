//
//  CreateBadge.swift
//  
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateBadge: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("badges")
            .id()
            .field("title", .string, .required)
            .field("text", .string)
            .field("background_color", .string, .required)
            .field("tint_color", .string, .required)
            .unique(on: "title", "text")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("badges").delete()
    }

}
