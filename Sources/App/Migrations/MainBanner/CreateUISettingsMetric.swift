//
//  CreateUISettingsMetric.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateUISettingsMetric: AsyncMigration {

    func prepare(on database: Database) async throws {

        try await database.schema("ui_settings_metrics")
            .id()
            .field("ui_settings_id",
                   .uuid,
                   .required,
                   .references("main_banners_ui_settings", "id", onDelete: .cascade))
            .field("width", .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("ui_settings_metrics").delete()
    }

}
