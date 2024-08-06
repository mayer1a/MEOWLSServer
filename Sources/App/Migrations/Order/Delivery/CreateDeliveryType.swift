//
//  CreateDeliveryType.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateDeliveryType: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("DeliveryType")
            .case("courier")
            .case("self_pickup")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("DeliveryType").delete()
    }

}
