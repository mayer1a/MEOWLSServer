//
//  ProductProperty.swift
//  
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

extension Product {

    final class ProductProperty: Model, Content, @unchecked Sendable, Hashable {

        static let schema = "product_properties"

        @ID(key: .id)
        var id: UUID?

        @Field(key: "name")
        var name: String

        @Field(key: "code")
        var code: String

        @Field(key: "selectable")
        var selectable: Bool

        @Children(for: \.$productProperty)
        var propertyValues: [PropertyValue]

        init() {}

        init(id: UUID? = nil, name: String, code: String, selectable: Bool) {
            self.id = id
            self.name = name
            self.code = code
            self.selectable = selectable
        }

    }

}

extension ProductProperty {

    var identifier: String {
        id?.uuidString ?? UUID().uuidString
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: ProductProperty, rhs: ProductProperty) -> Bool {
        lhs.id == rhs.id && lhs.code == rhs.code
    }

}

