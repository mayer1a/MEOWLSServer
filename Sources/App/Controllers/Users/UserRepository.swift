//
//  UserRepository.swift
//  
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

protocol UserRepositoryProtocol: Sendable {

    func get(_ user: User, withToken: Bool) async throws -> User.PublicDTO
    func add(_ model: User.CreateDTO) async throws -> User
    func refreshToken(for user: User) async throws -> User.PublicDTO
    func update(_ user: User, with model: User.UpdateDTO) async throws -> User.PublicDTO
    func delete(_ user: User) async throws

}

final class UserRepository: UserRepositoryProtocol {

    private let database: Database
    private let favoritesRepository: FavoritesRepositoryProtocol
    private let tokenRepository: TokenRepositoryProtocol

    init(database: Database,
         with favoritesRepository: FavoritesRepositoryProtocol,
         _ tokenRepository: TokenRepositoryProtocol) {

        self.database = database
        self.favoritesRepository = favoritesRepository
        self.tokenRepository = tokenRepository
    }

    func get(_ user: User, withToken: Bool = false) async throws -> User.PublicDTO {

        let token = try await user.$token.get(on: database)
        return try DTOBuilder.makeUser(from: user, with: withToken ? token : nil)
    }
    
    func add(_ model: User.CreateDTO) async throws -> User {

        let isAdmin = try await User.query(on: database).count() < 1
        let user = try model.toUser(with: isAdmin ? .admin : .user)

        do {
            try await user.save(on: database)
        } catch {
            throw ErrorFactory.badRequest(.phoneAlreadyUsed)
        }

        try await tokenRepository.update(for: user)
        try await favoritesRepository.add(user)

        return user
    }

    func refreshToken(for user: User) async throws -> User.PublicDTO {

        let token = try await tokenRepository.update(for: user)
        return try DTOBuilder.makeUser(from: user, with: token)
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

        return try DTOBuilder.makeUser(from: user)
    }

    func delete(_ user: User) async throws {
        do {
            try await user.delete(on: database)
        } catch {
            try await user.delete(force: true, on: database)
        }
    }

}
