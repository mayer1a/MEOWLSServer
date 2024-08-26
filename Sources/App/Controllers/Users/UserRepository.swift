//
//  UserRepository.swift
//  
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

protocol UserRepositoryProtocol: Sendable {

    func add(_ model: User.CreateDTO) async throws -> User.PublicDTO
    func get(_ user: User, withToken: Bool) async throws -> User.PublicDTO
    func refreshToken(for user: User) async throws -> User.PublicDTO
    func update(_ user: User, with model: User.UpdateDTO) async throws -> User.PublicDTO
    func delete(_ user: User) async throws

}

final class UserRepository: UserRepositoryProtocol {

    private let database: Database
    private let tokenRepository: TokenRepositoryProtocol
    private let cartRepository: CartRepositoryProtocol
    private let favoritesRepository: FavoritesRepositoryProtocol

    init(database: Database,
         with tokenRepository: TokenRepositoryProtocol,
         _ cartRepository: CartRepositoryProtocol,
         _ favoritesRepository: FavoritesRepositoryProtocol) {

        self.database = database
        self.tokenRepository = tokenRepository
        self.cartRepository = cartRepository
        self.favoritesRepository = favoritesRepository
    }

    func add(_ model: User.CreateDTO) async throws -> User.PublicDTO {
        let isAdmin = try await User.query(on: database).count() < 1
        let user = try model.toUser(with: isAdmin ? .admin : .user)

        do {
            try await user.save(on: database)
        } catch {
            throw ErrorFactory.badRequest(.phoneAlreadyUsed)
        }

        let token = try await tokenRepository.update(for: user)
        try await cartRepository.addCart(for: user)
        try await favoritesRepository.add(user)

        return try DTOFactory.makeUser(from: user, with: token)
    }

    func get(_ user: User, withToken: Bool = false) async throws -> User.PublicDTO {
        let token = try await user.$token.get(on: database)
        return try DTOFactory.makeUser(from: user, with: withToken ? token : nil)
    }

    func refreshToken(for user: User) async throws -> User.PublicDTO {
        let token = try await tokenRepository.update(for: user)
        return try DTOFactory.makeUser(from: user, with: token)
    }

    @discardableResult
    func update(_ user: User, with model: User.UpdateDTO) async throws -> User.PublicDTO {
        user.surname = model.surname
        user.name = model.name
        user.patronymic = model.patronymic
        user.birthday = model.birthday
        user.gender = model.gender
        user.email = model.email
        user.phone = model.phone

        if let password = model.password {
            user.passwordHash = try Bcrypt.hash(password)
        }

        try await user.update(on: database)

        return try DTOFactory.makeUser(from: user)
    }

    func delete(_ user: User) async throws {
        try await database.transaction { [weak self] transaction in

            guard let self else { throw ErrorFactory.serviceUnavailable(failures: [.databaseConnection])}

            try await tokenRepository.delete(user)

            do {
                try await deleteUser(user, in: transaction)
            } catch { // Attemp #2 with new salt UUID
                try await deleteUser(user, in: transaction)
            }
        }
    }

    private func deleteUser(_ user: User, in db: Database) async throws {
        user.phone = "\(user.phone)###\(UUID().uuidString)"
        user.email = user.email == nil ? nil : "\(user.email!)###\(UUID().uuidString)"
        try await user.update(on: db)
    }

}
