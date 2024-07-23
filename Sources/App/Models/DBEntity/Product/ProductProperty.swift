//
//  ProductProperty.swift
//  
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class ProductProperty: Model, Content, @unchecked Sendable {

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

    enum CodingKeys: String, CodingKey {
        case id, name, code, selectable
        case propertyValues = "property_values"
    }

}
