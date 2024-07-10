//
//  GenderMigration.swift
//
//
//  Created by Artem Mayer on 21.06.2024.
//

import Fluent

struct GenderMigration: AsyncMigration {

    func prepare(on database: Database) async throws {
        _ = try await database.enum("Gender")
            .case("man")
            .case("woman")
            .case("indeterminate")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("Gender").delete()
    }

}
