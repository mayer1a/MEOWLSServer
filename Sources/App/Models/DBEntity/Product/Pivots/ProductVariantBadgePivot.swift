//
//  ProductVariantBadgePivot.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class ProductVariantBadgePivot: Model, @unchecked Sendable {

    static let schema = "product_variants+badges"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_variant_id")
    var productVariant: ProductVariant

    @Parent(key: "badge_id")
    var badge: Badge

    init() {}

    init(id: UUID? = nil, productVariant: ProductVariant, badge: Badge) throws {
        self.id = id
        self.$productVariant.id = try productVariant.requireID()
        self.$badge.id = try badge.requireID()
    }

}
