//
//  PropertyValue.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class PropertyValue: Model, Content, @unchecked Sendable {

    static let schema = "property_values"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_property_id")
    var productProperty: ProductProperty

    @Siblings(through: ProductVariantsPropertyValues.self, from: \.$propertyValue, to: \.$productVariant)
    var productVariants: [ProductVariant]

    @Field(key: "value")
    var value: String

    enum CodingKeys: String, CodingKey {
        case id
        case productProperty = "product_property"
        case productVariants = "product_variants"
        case value
    }

    init() {}

    init(id: UUID? = nil, propertyID: ProductProperty.IDValue, value: String) {
        self.id = id
        self.$productProperty.id = propertyID
        self.value = value
    }

}
