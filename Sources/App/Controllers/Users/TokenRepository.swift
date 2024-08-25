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
        try await addUser(user)
    }

    @discardableResult
    func update(for user: User) async throws -> Token {
        try await database.transaction { [weak self] transaction in
            
            guard let self else { throw ErrorFactory.serviceUnavailable(failures: [.databaseConnection]) }

            try await user.$token.get(on: transaction)?.delete(on: transaction)
            let token = try await self.addUser(user, in: transaction)
            try await token.save(on: transaction)
            try await user.update(on: transaction)

            return token
        }
    }

    func delete(_ user: User) async throws {
        try await user.$token.get(on: database)?.delete(on: database)
    }

    private func addUser(_ user: User, in db: Database? = nil) async throws -> Token {
        let token = try Token.generate(for: user)
        try await token.save(on: db ?? database)

        return token
    }

}
