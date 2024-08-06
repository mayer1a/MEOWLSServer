//
//  CreateSectionType.swift
//  
//
//  Created by Artem Mayer on 10.07.2024.
//

import Fluent

struct CreateSectionType: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        _ = try await database.enum("SectionType")
            .case("text_expandable")
            .case("text_modal")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.enum("SectionType").delete()
    }

}

