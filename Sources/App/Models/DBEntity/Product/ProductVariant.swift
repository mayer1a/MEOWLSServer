//
//  ProductVariant.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

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

    @Field(key: "property_value_ids")
    var propertyValueIDs: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case article
        case shortName = "short_name"
        case price
        case availabilityInfo = "availability_info"
        case badges
        case propertyValueIDs = "property_value_ids"
    }

    init() {}

    init(id: UUID? = nil, productID: Product.IDValue, article: String, shortName: String, propertyValueIDs: [Int]?) {
        self.id = id
        self.$product.id = productID
        self.article = article
        self.shortName = shortName
        self.propertyValueIDs = propertyValueIDs
    }

}
