//
//  CreateAvailabilityType.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateAvailabilityType: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("AvailabilityType")
            .case("available")
            .case("delivery")
            .case("not_available")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("AvailabilityType").delete()
    }

}
