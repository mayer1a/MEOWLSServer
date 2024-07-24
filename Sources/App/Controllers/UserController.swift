//
//  UserController.swift
//
//
//  Created by Artem Mayer on 21.06.2024.
//

import Vapor
import Fluent

struct UserController: RouteCollection {

    @Sendable func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("api", "v1", "users")
        users.post("create", use: create)

        let basicAuthGroup = users.grouped(User.authenticator())
        basicAuthGroup.post("login", use: login)

        let tokenAuthGroup = users.grouped(Token.authenticator(), User.guardMiddleware())
        tokenAuthGroup.post("edit", use: edit)
        tokenAuthGroup.post("logout", use: logout)
        tokenAuthGroup.post("delete", use: delete)
    }

    @Sendable private func create(_ request: Request) async throws -> User.PublicDTO {
        let createUser = try request.content.decode(User.CreateDTO.self)
        try createUser.validate()
        let isAdmin = try await User.query(on: request.db).count() < 1
        let user = try createUser.toUser(with: isAdmin ? .admin : .user)

        do {
            try await user.save(on: request.db)
        } catch {
            throw CustomError(.conflict, code: "signUpError", reason: "Phone already used")
        }

        let token = try Token.generate(for: user)
        try await token.save(on: request.db)
        try await user.update(on: request.db)

        request.auth.login(user)
        
        return try await user.convertToPublic(with: token)
    }

    @Sendable private func login(_ request: Request) async throws -> User.PublicDTO {
        let user = try request.auth.require(User.self)

        try await user.$token.get(on: request.db)?.delete(on: request.db)
        let userToken = try Token.generate(for: user)
        try await userToken.save(on: request.db)

        return try await user.convertToPublic(with: userToken)
    }

    @Sendable private func edit(_ request: Request) async throws -> User.PublicDTO {
        let newUser = try request.content.decode(User.UpdateDTO.self)
        try newUser.validate()

        let user = try request.auth.require(User.self)
        try user.update(with: newUser)

        try await user.update(on: request.db)

        return try await user.convertToPublic()
    }

    @Sendable private func logout(_ request: Request) async throws -> DummyResponse {
        guard let user = request.auth.get(User.self) else {
            throw Abort(.unauthorized)
        }

        request.auth.logout(User.self)
        try await user.$token.get(on: request.db)?.delete(on: request.db)

        return DummyResponse()
    }

    @Sendable private func delete(_ request: Request) async throws -> DummyResponse {
        let user = try request.auth.require(User.self)
        request.auth.logout(User.self)

        do {
            try await user.delete(on: request.db)
        } catch {
            try await user.delete(force: true, on: request.db)
        }

        return DummyResponse()
    }

}
