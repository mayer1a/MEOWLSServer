//
//  CreateCategory.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import FluentPostgresDriver

struct CreateCategory: AsyncMigration {

    func prepare(on database: Database) async throws {

        try await database.transaction { transaction in

            try await transaction.schema("categories")
                .id()
                .field("code", .string, .required)
                .field("name", .string, .required)
                .field("parent_id", .uuid, .references("categories", "id", onDelete: .cascade))
                .field("main_banner_id", .uuid, .references("main_banners", "id", onDelete: .setNull))
                .field("has_children", .bool, .required, .sql(.default(SQLLiteral.boolean(false))))
                .unique(on: "parent_id", "code")
                .create()


            let postgres = (transaction as? PostgresDatabase)?.sql()

            try await postgres?.raw(createTSVectorSearchColumnSQL()).run()
            try await postgres?.raw(createGINIndexSQL()).run()
        }
    }

    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }

    private func createTSVectorSearchColumnSQL() -> SQLQueryString {

        let table: SQLQueryString = "CATEGORIES"
        let column: SQLQueryString = "SEARCH_NAME_VECTOR"
        return "ALTER TABLE \(table) ADD \(column) TSVECTOR GENERATED ALWAYS AS TO_TSVECTOR('russian', NAME) STORED;"
    }

    private func createGINIndexSQL() -> SQLQueryString {
        "CREATE INDEX ON CATEGORIES USING GIN(SEARCH_NAME_VECTOR);"
    }

}
