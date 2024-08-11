//
//  PromoCodesUsersPivot.swift
//  
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class PromoCodesUsersPivot: Model, @unchecked Sendable {

    static let schema = "promo_codes+users"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "promo_code_id")
    var promoCode: PromoCode

    @Parent(key: "user_id")
    var user: User

    init() {}

    init(id: UUID? = nil, promoCode: PromoCode, user: User) throws {
        self.id = id
        self.$promoCode.id = try promoCode.requireID()
        self.$user.id = try user.requireID()
    }

}
