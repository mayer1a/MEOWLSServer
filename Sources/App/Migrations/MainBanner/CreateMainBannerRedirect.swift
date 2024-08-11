//
//  CreateMainBannerRedirect.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateMainBannerRedirect: AsyncMigration {

    func prepare(on database: Database) async throws {

        let redirectType = try await database.enum("RedirectType").read()
        let objectType = try await database.enum("ObjectType").read()

        try await database.schema("main_banners_redirects")
            .id()
            .field("main_banner_id", .uuid, .required, .references("main_banners", "id", onDelete: .cascade))
            .field("redirect_type", redirectType, .required)
            .field("object_type", objectType, .required)
            .field("url", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("main_banners_redirects").delete()
    }

}
