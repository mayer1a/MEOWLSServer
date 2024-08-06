//
//  Price.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

extension ProductVariant {

    final class Price: Model, Content, @unchecked Sendable {

        static let schema = "prices"

        @ID(key: .id)
        var id: UUID?

        @OptionalParent(key: "product_variant_id")
        var productVariant: ProductVariant?

        @OptionalParent(key: "cart_item_id")
        var cartItem: CartItem?

        /// Old price
        @Field(key: "original_price")
        var originalPrice: Double

        @OptionalField(key: "discount")
        var discount: Double?

        /// New price
        @Field(key: "price")
        var price: Double

        init() {}

        init(id: UUID? = nil,
             productVariantID: ProductVariant.IDValue? = nil,
             cartItemID: CartItem.IDValue? = nil,
             originalPrice: Double,
             discount: Double?,
             price: Double) {

            self.id = id
            self.$productVariant.id = productVariantID
            self.$cartItem.id = cartItemID
            self.originalPrice = originalPrice
            self.discount = discount
            self.price = price
        }

    }

}
