//
//  ProductVariantsPropertyValues.swift
//
//
//  Created by Artem Mayer on 17.07.2024.
//

import Vapor
import Fluent

final class ProductVariantsPropertyValues: Model, @unchecked Sendable {

    static let schema = "product_variants+property_values"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_variant_id")
    var productVariant: ProductVariant

    @Parent(key: "property_value_id")
    var propertyValue: PropertyValue

    init() {}

    init(id: UUID? = nil, productVariant: ProductVariant, propertyValue: PropertyValue) throws {
        self.id = id
        self.$productVariant.id = try productVariant.requireID()
        self.$propertyValue.id = try propertyValue.requireID()
    }

}
