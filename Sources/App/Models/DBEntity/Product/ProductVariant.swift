//
//  ProductVariant.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

extension Product {

    final class ProductVariant: Model, Content, @unchecked Sendable {

        static let schema = "product_variants"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "product_id")
        var product: Product

        @Field(key: "article")
        var article: String

        @Field(key: "short_name")
        var shortName: String

        @OptionalChild(for: \.$productVariant)
        var price: Price?

        @OptionalChild(for: \.$productVariant)
        var availabilityInfo: AvailabilityInfo?

        @Siblings(through: ProductVariantBadgePivot.self, from: \.$productVariant, to: \.$badge)
        var badges: [Badge]

        @Siblings(through: ProductVariantsPropertyValues.self, from: \.$productVariant, to: \.$propertyValue)
        var propertyValues: [PropertyValue]

        init() {}

        init(id: UUID? = nil, productID: Product.IDValue, article: String, shortName: String) {
            self.id = id
            self.$product.id = productID
            self.article = article
            self.shortName = shortName
        }

    }

}
