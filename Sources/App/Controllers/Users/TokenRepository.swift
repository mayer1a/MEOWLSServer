//
//  TokenRepository.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

protocol TokenRepositoryProtocol: Sendable {

    @discardableResult func add(_ user: User) async throws -> Token
    @discardableResult func update(for user: User) async throws -> Token
    func delete(_ user: User) async throws

}

final class TokenRepository: TokenRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    @discardableResult
    func add(_ user: User) async throws -> Token {

        let token = try Token.generate(for: user)
        try await token.save(on: database)

        return token
    }

    @discardableResult
    func update(for user: User) async throws -> Token {

        try await user.$token.get(on: database)?.delete(on: database)
        let token = try await add(user)
        try await token.save(on: database)
        try await user.update(on: database)

        return token
    }

    func delete(_ user: User) async throws {

        try await user.$token.get(on: database)?.delete(on: database)
    }

}
