//
//  Favorites.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class Favorites: Model, Content, @unchecked Sendable {

    static let schema = "favorites"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "user_id")
    var user: User

    @Siblings(through: FavoritesProductsPivot.self, from: \.$favorites, to: \.$product)
    var products: [Product]

    init() {}

    init(id: UUID? = nil, userID: User.IDValue) {
        self.id = id
        self.$user.id = userID
    }

}
