//
//  Category.swift
//
//
//  Created by Artem Mayer on 11.07.2024.
//

import Vapor
import Fluent

final class Category: Model, @unchecked Sendable {

    static let schema = "categories"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "code")
    var code: String

    @Field(key: "name")
    var name: String

    @OptionalParent(key: "parent_id")
    var parent: Category?

    @Siblings(through: CategoriesProductsPivot.self, from: \.$category, to: \.$product)
    var products: [Product]

    @Children(for: \.$parent)
    var childCategories: [Category]

    @OptionalChild(for: \.$category)
    var image: Image?

    init() {}

    init(id: UUID? = nil, code: String, name: String, parent: Category.IDValue?) {
        self.id = id
        self.code = code
        self.name = name
        self.$parent.id = parent
    }

    enum CodingKeys: String, CodingKey {
        case id, code, name, parent, products
        case childCategories = "child_categories"
        case image
    }
    
}
