//
//  CreateSection.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Fluent

struct CreateSection: AsyncMigration {

    func prepare(on database: Database) async throws {

        let type = try await database.enum("SectionType").read()
        
        try await database.schema("sections")
            .id()
            .field("title", .string, .required)
            .field("type", type, .required)
            .field("text", .string, .required)
            .field("link", .string)
            .field("product_id", .uuid, .required, .references("products", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("sections").delete()
    }

}
