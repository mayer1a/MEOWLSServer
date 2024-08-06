//
//  CreateDiscountType.swift
//  
//
//  Created by Artem Mayer on 25.07.2024.
//

import Fluent

struct CreateDiscountType: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("DiscountType")
            .case("fixed_amount")
            .case("percent")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("DiscountType").delete()
    }

}
