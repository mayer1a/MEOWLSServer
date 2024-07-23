//
//  CreateSale.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateSale: AsyncMigration {

    func prepare(on database: Database) async throws {
        let saleType = try await database.enum("SaleType").read()
        try await database.schema("sales")
            .id()
            .field("code", .string, .required)
            .field("sale_type", saleType)
            .field("title", .string, .required)
            .field("startDate", .date, .required)
            .field("endDate", .date, .required)
            .field("disclaimer", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("sales").delete()
    }

}

