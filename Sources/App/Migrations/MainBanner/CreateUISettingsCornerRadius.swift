//
//  CreateUISettingsCornerRadius.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateUISettingsCornerRadius: AsyncMigration {

    func prepare(on database: Database) async throws {

        try await database.schema("ui_settings_corner_radiuses")
            .id()
            .field("ui_settings_id",
                   .uuid,
                   .required,
                   .references("main_banners_ui_settings", "id", onDelete: .cascade))
            .field("top_left", .int, .required)
            .field("top_right", .int, .required)
            .field("bottom_left", .int, .required)
            .field("bottom_right", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("ui_settings_corner_radiuses").delete()
    }

}
