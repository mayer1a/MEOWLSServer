//
//  CreateUser.swift
//
//
//  Created by Artem Mayer on 21.06.2024.
//

import Fluent

struct CreateUser: AsyncMigration {

    func prepare(on database: Database) async throws {

        let gender = try await database.enum("Gender").read()
        let role = try await database.enum("Role").read()
        
        try await database.schema("users")
            .id()
            .field("surname", .string)
            .field("name", .string)
            .field("patronymic", .string)
            .field("birthday", .date)
            .field("gender", gender)
            .field("email", .string)
            .field("password_hash", .string, .required)
            .field("phone", .string, .required)
            .field("role", role, .required)
            .unique(on: "email")
            .unique(on: "phone")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }

}
