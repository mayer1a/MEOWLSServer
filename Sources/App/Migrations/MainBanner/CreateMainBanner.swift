//
//  CreateMainBanner.swift
//  
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateMainBanner: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        let placeType = try await database.enum("PlaceType").read()
        
        try await database.schema("main_banners")
            .id()
            .field("title", .string)
            .field("place_type", placeType)
            .field("place_index", .int, .required)
            .field("parent_id", .uuid, .references("main_banners", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("main_banners").delete()
    }

}
