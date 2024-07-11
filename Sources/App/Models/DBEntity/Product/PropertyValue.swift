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

    @OptionalParent(key: "product_id")
    var product: Product?

    @Parent(key: "product_property_id")
    var productProperty: ProductProperty

    @Field(key: "value")
    var value: String

    enum CodingKeys: String, CodingKey {
        case id
        case product = "product_id"
        case productProperty = "property_id"
        case value
    }

    init() {}

    init(id: UUID? = nil, productID: Product.IDValue, propertyID: ProductProperty.IDValue, value: String) {
        self.id = id
        self.$product.id = productID
        self.$productProperty.id = propertyID
        self.value = value
    }

}
