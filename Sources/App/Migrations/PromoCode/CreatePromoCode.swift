//
//  CreatePromoCode.swift
//  
//
//  Created by Artem Mayer on 25.07.2024.
//

import Fluent

struct CreatePromoCode: AsyncMigration {

    func prepare(on database: Database) async throws {

        let discountType = try await database.enum("DiscountType").read()
        
        try await database.schema("promo_codes")
            .id()
            .field("code", .string)
            .field("discount", .int, .required)
            .field("discount_type", discountType)
            .field("is_active", .bool, .required)
            .field("start_date", .date, .required)
            .field("end_date", .date, .required)
            .unique(on: "code")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("promo_codes").delete()
    }

}
