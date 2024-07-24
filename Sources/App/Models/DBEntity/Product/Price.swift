//
//  Price.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class Price: Model, Content, @unchecked Sendable {
    
    static let schema = "prices"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_variant_id")
    var productVariant: ProductVariant

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
         productVariantID: ProductVariant.IDValue,
         originalPrice: Double,
         discount: Double?,
         price: Double) {

        self.id = id
        self.$productVariant.id = productVariantID
        self.originalPrice = originalPrice
        self.discount = discount
        self.price = price
    }

    enum CodingKeys: String, CodingKey {
        case id
        case productVariant = "product_variant"
        case originalPrice = "original_price"
        case discount, price
    }

}
