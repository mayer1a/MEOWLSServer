//
//  FavoritesRepository.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Vapor
import Fluent

protocol FavoritesRepositoryProtocol: Sendable {

    func add(_ user: User) async throws
    func get(for user: User) async throws -> FavoritesDTO
    func update(productsIDs: [Product.IDValue], for user: User) async throws
    func delete(productsIDs: [Product.IDValue], for user: User) async throws

}

final class FavoritesRepository: FavoritesRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func add(_ user: User) async throws {
        let favorites = Favorites(userID: try user.requireID())
        try await favorites.save(on: database)
    }

    func get(for user: User) async throws -> FavoritesDTO {
        let favorites = try await eagerLoadFavorites(userID: user.requireID())
        return try DTOFactory.makeFavorites(from: favorites)
    }

    func update(productsIDs: [Product.IDValue], for user: User) async throws {
        try await database.transaction { transaction in
            let products = try await Product.query(on: transaction)
                .filter(\.$id ~~ productsIDs.reversed())
                .all()

            let favorites = try await user.$favorites.get(on: transaction)

            try await products.asyncForEach { product in
                if try await favorites?.$products.isAttached(to: product, on: transaction) == true {
                    throw ErrorFactory.badRequest(.productAlreadyStarred)
                } else {
                    try await favorites?.$products.attach(product, on: transaction)
                }
            }
        }
    }

    func delete(productsIDs: [Product.IDValue], for user: User) async throws {
        try await database.transaction { transaction in
            let products = try await Product.query(on: transaction)
                .filter(\.$id ~~ productsIDs)
                .all()

            try await user.$favorites.get(on: transaction)?
                .$products
                .detach(products, on: transaction)
        }
    }

    private func eagerLoadFavorites(userID: UUID) async throws -> Favorites {
        let favorites = try await Favorites.query(on: database)
            .filter(\.$user.$id == userID)
            .with(\.$products, { product in
                product
                    .with(\.$images)
                    .with(\.$variants) { variant in
                        variant
                            .with(\.$price)
                            .with(\.$availabilityInfo)
                            .with(\.$badges)
                    }
            })
            .first()

        guard let favorites else { throw ErrorFactory.internalError(.fetchFavoritesError) }

        return favorites
    }

}

