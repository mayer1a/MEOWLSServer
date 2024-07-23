//
//  CreateUISettingsSpacing.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateUISettingsSpacing: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("ui_settings_spacings")
            .id()
            .field("ui_settings_id", .uuid, .required, .references("main_banners_ui_settings", "id", onDelete: .cascade))
            .field("top", .int, .required)
            .field("bottom", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("ui_settings_spacings").delete()
    }

}
