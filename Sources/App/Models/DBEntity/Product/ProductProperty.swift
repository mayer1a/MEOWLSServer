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

    @Parent(key: "product_id")
    var product: Product

    @Field(key: "name")
    var name: String

    @Field(key: "code")
    var code: String

    @Field(key: "selectable")
    var selectable: Bool

    @Children(for: \.$productProperty)
    var propertyValueID: [PropertyValue]

    init() {}
    
    init(id: UUID? = nil, productID: Product.IDValue, name: String, code: String, selectable: Bool) {
        self.id = id
        self.$product.id = productID
        self.name = name
        self.code = code
        self.selectable = selectable
    }

}
