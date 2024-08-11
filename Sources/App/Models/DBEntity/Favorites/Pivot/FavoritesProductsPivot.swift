//
//  FavoritesProductsPivot.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class FavoritesProductsPivot: Model, @unchecked Sendable {

    static let schema = "favorites+products"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_id")
    var product: Product

    @Parent(key: "favorites_id")
    var favorites: Favorites

    @Timestamp(key: "created_at", on: .create, format: .default)
    var createdAt: Date?

    init() {}

    init(id: UUID? = nil, product: Product, favorites: Favorites) throws {
        self.id = id
        self.$product.id = try product.requireID()
        self.$favorites.id = try favorites.requireID()
    }

}
