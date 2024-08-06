//
//  CreateImageDimension.swift
//  
//
//  Created by Artem Mayer on 11.07.2024.
//

import Fluent

struct CreateImageDimension: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("image_dimensions")
            .id()
            .field("image_id", .uuid, .required, .references("images", "id", onDelete: .cascade))
            .field("width", .int, .required)
            .field("height", .int, .required)
            .unique(on: "image_id", "width")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("image_dimensions").delete()
    }

}
