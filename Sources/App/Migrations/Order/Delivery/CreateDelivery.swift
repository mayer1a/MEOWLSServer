//
//  CreateDelivery.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreateDelivery: AsyncMigration {

    func prepare(on database: Database) async throws {
        let deliveryType = try await database.enum("DeliveryType").read()
        try await database.schema("deliveries")
            .id()
            .field("order_id", .uuid, .required, .references("orders", "id", onDelete: .cascade))
            .field("type", deliveryType, .required)
            .field("delivery_date", .date)
            .unique(on: "order_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("deliveries").delete()
    }

}
