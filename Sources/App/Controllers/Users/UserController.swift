//
//  UserController.swift
//
//
//  Created by Artem Mayer on 21.06.2024.
//

import Vapor
import Fluent

struct UserController: RouteCollection {

    let userRepository: UserRepositoryProtocol
    let tokenRepository: TokenRepositoryProtocol
    let addressRepository: AddressRepositoryProtocol

    init(with userRepository: UserRepositoryProtocol, 
         _ tokenRepository: TokenRepositoryProtocol,
         _ addressRepository: AddressRepositoryProtocol) {

        self.userRepository = userRepository
        self.tokenRepository = tokenRepository
        self.addressRepository = addressRepository
    }

    func boot(routes: RoutesBuilder) throws {

        let users = routes.grouped("api", "v1", "users")
        users.post("create", use: create)

        let basicAuthGroup = users.grouped(User.authenticator())
        basicAuthGroup.post("login", use: login)

        let tokenAuthGroup = users.grouped(Token.authenticator(), User.guardMiddleware())
        tokenAuthGroup.get("", use: get)
        tokenAuthGroup.get("address", use: getAddress)
        tokenAuthGroup.post("edit", use: edit)
        tokenAuthGroup.post("logout", use: logout)
        tokenAuthGroup.post("delete", use: delete)
        tokenAuthGroup.post("refresh_token", use: refreshToken)
    }

    @Sendable private func create(_ request: Request) async throws -> User.PublicDTO {

        let createUser = try request.content.decode(User.CreateDTO.self)
        try createUser.validate()

        let user = try await userRepository.add(createUser)

        return try await userRepository.get(user, withToken: true)
    }

    @Sendable private func login(_ request: Request) async throws -> User.PublicDTO {

        let user = try request.auth.require(User.self)
        return try await userRepository.refreshToken(for: user)
    }

    @Sendable private func get(_ request: Request) async throws -> User.PublicDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        return try await userRepository.get(user, withToken: false)
    }

    @Sendable private func getAddress(_ request: Request) async throws -> AddressDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        return try await addressRepository.getAddress(for: user)
    }

    @Sendable private func edit(_ request: Request) async throws -> User.PublicDTO {

        let userChanges = try request.content.decode(User.UpdateDTO.self)
        try userChanges.validate()

        let user = try request.auth.require(User.self)
        
        return try await userRepository.update(user, with: userChanges)
    }

    @Sendable private func logout(_ request: Request) async throws -> DummyResponse {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        request.auth.logout(User.self)

        try await tokenRepository.delete(user)

        return DummyResponse()
    }

    @Sendable private func delete(_ request: Request) async throws -> DummyResponse {
        
        let user = try request.auth.require(User.self)
        request.auth.logout(User.self)

        try await userRepository.delete(user)

        return DummyResponse()
    }

    @Sendable private func refreshToken(_ request: Request) async throws -> User.PublicDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        return try await userRepository.refreshToken(for: user)
    }

}
