//
//  CreateDeliveryTimeInterval.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateDeliveryTimeInterval: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("delivery_time_intervals")
            .id()
            .field("from", .string, .required)
            .field("to", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("delivery_time_intervals").delete()
    }

}
