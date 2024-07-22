//
//  CategoriesProductsPivot.swift
//  
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

final class CategoriesProductsPivot: Model, @unchecked Sendable {

    static let schema = "categories+products"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_id")
    var product: Product

    @Parent(key: "category_id")
    var category: Category

    init() {}

    init(id: UUID? = nil, product: Product, category: Category) throws {
        self.id = id
        self.$product.id = try product.requireID()
        self.$category.id = try category.requireID()
    }

}
