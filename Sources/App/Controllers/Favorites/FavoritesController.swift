//
//  FavoritesController.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

struct FavoritesController: RouteCollection {

    let favoritesRepository: FavoritesRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {
        let favorites = routes.grouped("api", "v1", "favorites")

        let tokenAuthGroup = favorites.grouped(Token.authenticator(), User.guardMiddleware())
        tokenAuthGroup.get("", use: get)
        tokenAuthGroup.get("count", use: getCount)
        tokenAuthGroup.post("star", use: starProduct)
        tokenAuthGroup.post("unstar", use: unstarProduct)
    }

    @Sendable private func get(_ request: Request) async throws -> PaginationResponse<ProductDTO> {
        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }
        let page = try request.query.decode(PageRequest.self)
        return try await favoritesRepository.get(for: user, with: page)
    }

    @Sendable private func getCount(_ request: Request) async throws -> FavoritesCountDTO {
        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        return try await favoritesRepository.getCount(for: user)
    }

    @Sendable private func starProduct(_ request: Request) async throws -> DummyResponse {
        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        let productsIDs = try request.content.decode([UUID].self)
        if let error = try await favoritesRepository.update(productsIDs: productsIDs, for: user) {
            throw error
        }

        return DummyResponse()
    }

    @Sendable private func unstarProduct(_ request: Request) async throws -> DummyResponse {
        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        let productsIDs = try request.content.decode([UUID].self)
        try await favoritesRepository.delete(productsIDs: productsIDs, for: user)

        return DummyResponse()
    }

}
