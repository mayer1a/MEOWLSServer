//
//  File.swift
//  
//
//  Created by Artem Mayer on 21.06.2024.
//

import Vapor
import Fluent

struct UserController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("api", "v1", "users")

        users.post("create", use: create)
        users.post("login", use: login)

        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthGroup = users.grouped(tokenAuthMiddleware, guardAuthMiddleware)

        tokenAuthGroup.post("logout", use: logout)
        tokenAuthGroup.post("edit", use: edit)
    }

    private func create(_ request: Request) async throws -> User.Public {
        let user = try request.content.decode(User.self)
        user.password = try Bcrypt.hash(user.password)

        do {
            try await user.save(on: request.db)
        } catch {
            throw Abort(.custom(code: 409, reasonPhrase: "Email already used"))
        }

        let token = try Token.generate(for: user)
        try await token.save(on: request.db)

//        try await user.update(on: request.db)
        
        return try await user.convertToPublic(request.db)
    }

    private func login(_ request: Request) async throws -> Token {
        let user = try request.auth.require(User.self)
        let token = try Token.generate(for: user)
        return token
    }

    private func logout(_ request: Request) async throws -> Bool {
        guard
            let user = try await User.find(request.parameters.get("id"), on: request.db),
            let token = try await Token.find(user.token?.id, on: request.db)
        else {
            throw Abort(.notFound)
        }
        try await token.delete(on: request.db)
        return true
    }

    private func edit(_ request: Request) async throws -> Bool {
        return true
    }

}

