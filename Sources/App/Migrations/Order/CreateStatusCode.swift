//
//  CreateStatusCode.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateStatusCode: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("StatusCode")
            .case("CANCELED")
            .case("COMPLETED")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("StatusCode").delete()
    }

}
