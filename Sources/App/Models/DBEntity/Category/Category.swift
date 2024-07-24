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

    @OptionalChild(for: \.$category)
    var productsSet: MainBanner.Redirect.ProductsSet?

    @OptionalParent(key: "main_banner_id")
    var mainBanner: MainBanner?

    init() {}

    init(id: UUID? = nil,
         code: String,
         name: String,
         parent: Category.IDValue?,
         mainBannerID: MainBanner.IDValue? = nil) {
        
        self.id = id
        self.code = code
        self.name = name
        self.$parent.id = parent
        self.$mainBanner.id = mainBannerID
    }
    
}
