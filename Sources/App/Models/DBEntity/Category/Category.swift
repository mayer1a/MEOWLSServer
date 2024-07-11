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

    @OptionalParent(key: "parent_id")
    var parent: Category?

    @Field(key: "count")
    var count: Int

    @Children(for: \.$category)
    var products: [Product]

    @Field(key: "child_categories")
    var childCategories: [UUID]

    init() {}

    init(id: UUID? = nil, code: String, parent: Category.IDValue?, count: Int, childCategories: [UUID]) {
        self.id = id
        self.code = code
        self.$parent.id = parent
        self.count = count
        self.childCategories = childCategories
    }

}
