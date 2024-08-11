//
//  CreateProduct.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import FluentPostgresDriver

struct CreateProduct: AsyncMigration {

    func prepare(on database: Database) async throws {

        try await database.transaction { transaction in

            try await transaction.schema("products")
                .id()
                .field("name", .string, .required)
                .field("code", .string, .required)
                .field("allow_quick_buy", .bool, .required)
                .field("default_variant_article", .string)
                .field("delivery_conditions_url", .string)
                .field("main_banner_id", .uuid, .references("main_banners", "id", onDelete: .setNull))
                .field("sale_id", .uuid, .references("sales", "id", onDelete: .setNull))
                .unique(on: "code")
                .create()

            let postgres = (transaction as? PostgresDatabase)?.sql()

            try await postgres?.raw(createTSVectorSearchColumnSQL()).run()
            try await postgres?.raw(createGINIndexSQL()).run()
        }
    }

    func revert(on database: Database) async throws {
        try await database.schema("products").delete()
    }

    private func createTSVectorSearchColumnSQL() -> SQLQueryString {
        
        let table: SQLQueryString = "PRODUCTS"
        let column: SQLQueryString = "SEARCH_NAME_VECTOR"
        return "ALTER TABLE \(table) ADD \(column) TSVECTOR GENERATED ALWAYS AS TO_TSVECTOR('russian', NAME) STORED;"
    }

    private func createGINIndexSQL() -> SQLQueryString {
        "CREATE INDEX ON PRODUCTS USING GIN(SEARCH_NAME_VECTOR);"
    }

}
