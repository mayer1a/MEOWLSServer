//
//  CreatePaymentType.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Fluent

struct CreatePaymentType: AsyncMigration {

    func prepare(on database: Database) async throws {
        _ = try await database.enum("PaymentType")
            .case("card")
            .case("cash")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("PaymentType").delete()
    }

}
