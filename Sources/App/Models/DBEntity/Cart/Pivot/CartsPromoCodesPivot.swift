//
//  CartsPromoCodesPivot.swift
//  
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor
import Fluent

final class CartsPromoCodesPivot: Model, @unchecked Sendable {

    static let schema = "carts+promo_codes"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "cart_id")
    var cart: Cart

    @Parent(key: "promo_code_id")
    var promoCode: PromoCode

    init() {}

    init(id: UUID? = nil, cart: Cart, promoCode: PromoCode) throws {
        self.id = id
        self.$promoCode.id = try promoCode.requireID()
        self.$cart.id = try cart.requireID()
    }

}
