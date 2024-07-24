//
//  CreateUserRole.swift
//
//
//  Created by Artem Mayer on 29.06.2024.
//

import Fluent

struct CreateUserRole: AsyncMigration {

    func prepare(on database: Database) async throws {
        _ = try await database.enum("Role")
            .case("admin")
            .case("user")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("Role").delete()
    }

}
