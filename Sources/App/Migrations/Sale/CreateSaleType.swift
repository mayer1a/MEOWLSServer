//
//  SaleType.swift
//  
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateSaleType: AsyncMigration {

    func prepare(on database: Database) async throws {
        _ = try await database.enum("SaleType")//.read()
            .case("online")
            .case("offline")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.enum("SaleType").delete()
    }

}
