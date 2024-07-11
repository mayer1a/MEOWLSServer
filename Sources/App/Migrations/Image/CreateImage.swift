//
//  CreateImage.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateImage: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("images")
            .id()
            .field("small", .string)
            .field("medium", .string)
            .field("large", .string)
            .field("original", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("images").delete()
    }

}
