//
//  CreateOrder.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import SQLKit
import Fluent

struct CreateOrder: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        let statusCode = try await database.enum("StatusCode").read()
        let paymentType = try await database.enum("PaymentType").read()

        try await database.schema("orders")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("number", .int, .required, .sql(.default(SQLRaw("nextval('order_number_sequence'::regclass)"))))
            .field("status_code", statusCode, .required)
            .field("status", .string, .required)
            .field("can_be_paid_online", .bool, .required)
            .field("paid", .bool, .required)
            .field("order_date", .date, .required)
            .field("cancelable", .bool, .required)
            .field("repeat_allowed", .bool, .required)
            .field("comment", .string)
            .field("payment_type", paymentType, .required)
            .unique(on: "number")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("orders").delete()
    }

}
