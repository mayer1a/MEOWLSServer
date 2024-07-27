//
//  Cart.swift
//  
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class Cart: Model, @unchecked Sendable {

    static let schema = "carts"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "user_id")
    var user: User

    @Children(for: \.$cart)
    var items: [CartItem]

    @Siblings(through: CartsPromoCodesPivot.self, from: \.$cart, to: \.$promoCode)
    var promoCodes: [PromoCode]

    @Children(for: \.$cart)
    var itemsSummary: [Summary]

    @OptionalChild(for: \.$cart)
    var total: Summary?

    init() {}

    init(id: UUID? = nil, userID: User.IDValue) {
        self.id = id
        self.$user.id = userID
    }

}

