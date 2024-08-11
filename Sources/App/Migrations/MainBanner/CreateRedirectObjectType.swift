//
//  CreateRedirectObjectType.swift
//
//
//  Created by Artem Mayer on 05.08.2024.
//

import Fluent

struct CreateRedirectObjectType: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("ObjectType")
            .case("Product")
            .case("Sale")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("ObjectType").delete()
    }

}
