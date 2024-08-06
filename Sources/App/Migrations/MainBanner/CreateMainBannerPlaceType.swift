//
//  CreateMainBannerPlaceType.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Fluent

struct CreateMainBannerPlaceType: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("PlaceType")
            .case("categories")
            .case("banners_horizontal")
            .case("products_collection")
            .case("banners_vertical")
            .case("single_banner")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("PlaceType").delete()
    }


}
