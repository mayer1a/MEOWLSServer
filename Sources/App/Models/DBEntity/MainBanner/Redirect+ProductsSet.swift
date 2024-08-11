//
//  Redirect+ProductsSet.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension Redirect {

    final class ProductsSet: Model, Content, @unchecked Sendable {

        static let schema = "main_banners_products_sets"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "redirect_id")
        var redirect: Redirect

        @Field(key: "name")
        var name: String

        @OptionalParent(key: "category_id")
        var category: Category?

        @OptionalField(key: "query")
        var query: String?

        init() {}

        init(id: UUID? = nil,
             redirectID: Redirect.IDValue,
             name: String,
             categoryID: Category.IDValue? = nil,
             query: String?) {

            self.id = id
            self.name = name
            self.$redirect.id = redirectID
            self.$category.id = categoryID
            self.query = query
        }

    }

}
