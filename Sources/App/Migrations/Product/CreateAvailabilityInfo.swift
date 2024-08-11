//
//  CreateAvailabilityInfo.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateAvailabilityInfo: AsyncMigration {

    func prepare(on database: Database) async throws {

        let type = try await database.enum("AvailabilityType").read()
        
        try await database.schema("availability_infos")
            .id()
            .field("product_variant_id", .uuid, .references("product_variants", "id", onDelete: .cascade))
            .field("type", type, .required)
            .field("delivery_duration", .int)
            .field("count", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("availability_infos").delete()
    }

}
