//
//  PromoCodesProductsPivot.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class PromoCodesProductsPivot: Model, @unchecked Sendable {

    static let schema = "promo_codes+products"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "promo_code_id")
    var promoCode: PromoCode

    @Parent(key: "product_id")
    var product: Product

    init() {}

    init(id: UUID? = nil, promoCode: PromoCode, product: Product) throws {
        self.id = id
        self.$promoCode.id = try promoCode.requireID()
        self.$product.id = try product.requireID()
    }

}
