//
//  CreateRedirectRedirectType.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateRedirectRedirectType: AsyncMigration {

    func prepare(on database: Database) async throws {
        _ = try await database.enum("RedirectType")
            .case("object")
            .case("products_collection")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("RedirectType").delete()
    }

}
