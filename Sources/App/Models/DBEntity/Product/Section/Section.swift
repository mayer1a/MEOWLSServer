//
//  Section.swift
//  
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class Section: Model, Content, @unchecked Sendable {

    static let schema = "sections"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_id")
    var product: Product

    @Field(key: "title")
    var title: String

    @Enum(key: "type")
    var type: SectionType

    @Field(key: "text")
    var text: String

    @Field(key: "link")
    var link: String?

    init() {}

    init(id: UUID? = nil, productID: Product.IDValue, title: String, type: SectionType, text: String, link: String?) {
        self.id = id
        self.$product.id = productID
        self.title = title
        self.type = type
        self.text = text
        self.link = link
    }


}
