//
//  CreateSummaryType.swift
//
//
//  Created by Artem Mayer on 21.08.2024.
//

import Fluent

struct CreateSummaryType: AsyncMigration {

    func prepare(on database: Database) async throws {

        _ = try await database.enum("SummaryType")
            .case("ITEMS_WITHOUT_DISCOUNT")
            .case("DISCOUNT")
            .case("PROMO_DISCOUNT")
            .case("DELIVERY")
            .case("TOTAL")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("SummaryType").delete()
    }

}
