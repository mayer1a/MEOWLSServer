//
//  CreateMainBannerUISettings.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateMainBannerUISettings: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        try await database.schema("main_banners_ui_settings")
            .id()
            .field("main_banner_id", .uuid, .required, .references("main_banners", "id", onDelete: .cascade))
            .field("background_color", .string)
            .field("auto_sliding_timeout", .int)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("main_banners_ui_settings").delete()
    }

}
