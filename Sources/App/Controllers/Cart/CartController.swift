//
//  CartController.swift
//  
//
//  Created by Artem Mayer on 07.08.2024.
//

import Vapor
import Fluent

struct CartController: RouteCollection {

    let cartRepository: CartRepositoryProtocol
//    let promocodeRepository: PromocodeRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {

        let cart = routes.grouped("api", "v1", "cart")

        let tokenCartGroup = cart.grouped(Token.authenticator(), User.guardMiddleware())
        
        tokenCartGroup.get("", use: get)
        tokenCartGroup.post("update", use: update)
//        cart.post("promo_code", "apply", use: applyPromocode)
    }


    @Sendable func get(_ request: Request) async throws -> CartDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        return try await cartRepository.getCart(for: user)
    }

        return try await cartRepository.get(for: user)
    }

    @Sendable func update(_ request: Request) async throws -> CartDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        let cartRequest = try request.content.decode(CartRequest.self)

        return try await cartRepository.update(for: user, with: cartRequest)
    }

}
