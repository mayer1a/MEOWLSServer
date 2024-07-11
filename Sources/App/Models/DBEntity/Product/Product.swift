//
//  Product.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class Product: Model, Content, @unchecked Sendable {

    static let schema = "products"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "category_id")
    var category: Category

    @Field(key: "name")
    var name: String

    @Field(key: "code")
    var code: String

    @Siblings(through: ProductImagePivot.self, from: \.$product, to: \.$image)
    var images: [Image]

    @Field(key: "allow_quick_buy")
    var allowQuickBuy: String

    @Children(for: \.$product)
    var variants: [ProductVariant]

    @Children(for: \.$product)
    var properties: [ProductProperty]

    @Children(for: \.$product)
    var propertyValues: [PropertyValue]

    @Field(key: "default_variant_article")
    var defaultVariantArticle: String?

    @Field(key: "delivery_conditions_url")
    var deliveryConditionsURL: String?

    @Children(for: \.$product)
    var sections: [Section]

    enum CodingKeys: String, CodingKey {
        case id, name, code, images
        case allowQuickBuy = "allow_quick_buy"
        case price, badges, variants, properties
        case propertyValues = "property_values"
        case defaultVariantArticle = "default_variant_article"
        case deliveryConditionsURL = "delivery_conditions_url"
        case sections
    }

    init() { }

    init(id: UUID? = nil,
         categoryID: Category.IDValue,
         name: String,
         code: String,
         allowQuickBuy: String,
         defaultVariantArticle: String?,
         deliveryConditionsURL: String?) {

        self.id = id
        self.$category.id = categoryID
        self.name = name
        self.code = code
        self.allowQuickBuy = allowQuickBuy
        self.defaultVariantArticle = defaultVariantArticle
        self.deliveryConditionsURL = deliveryConditionsURL
    }

}
