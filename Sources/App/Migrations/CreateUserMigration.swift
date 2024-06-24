//
//  CreateUserMigration.swift
//
//
//  Created by Artem Mayer on 21.06.2024.
//

import Vapor
import Fluent

struct CreateUserMigration: AsyncMigration {

    func prepare(on database: Database) async throws {
        let gender = try await database.enum("Gender").read()
        try await database.schema("users")
            .id()
            .field("surname", .string)
            .field("name", .string)
            .field("patronymic", .string)
            .field("birthday", .date)
            .field("gender", gender)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .field("phone", .string)
            .field("credit_card", .string)
            .unique(on: "email")
            .unique(on: "phone")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }

}
