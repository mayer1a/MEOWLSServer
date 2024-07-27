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

    @Siblings(through: CategoriesProductsPivot.self, from: \.$product, to: \.$category)
    var categories: [Category]

    @Field(key: "name")
    var name: String

    @Field(key: "code")
    var code: String

    @Siblings(through: ProductImagePivot.self, from: \.$product, to: \.$image)
    var images: [Image]

    @Field(key: "allow_quick_buy")
    var allowQuickBuy: Bool

    @Children(for: \.$product)
    var variants: [ProductVariant]

    @OptionalField(key: "default_variant_article")
    var defaultVariantArticle: String?

    @OptionalField(key: "delivery_conditions_url")
    var deliveryConditionsURL: String?

    @Children(for: \.$product)
    var sections: [Section]

    @OptionalParent(key: "main_banner_id")
    var mainBanner: MainBanner?

    @OptionalParent(key: "sale_id")
    var sale: Sale?

    @Siblings(through: FavoritesProductsPivot.self, from: \.$product, to: \.$favorites)
    var favorites: [Favorites]

    @Siblings(through: PromoCodesProductsPivot.self, from: \.$product, to: \.$promoCode)
    var promoCodes: [PromoCode]

    init() { }

    init(id: UUID? = nil,
         name: String,
         code: String,
         allowQuickBuy: Bool,
         defaultVariantArticle: String?,
         deliveryConditionsURL: String?,
         mainBannerID: MainBanner.IDValue? = nil,
         saleID: Sale.IDValue? = nil) {

        self.id = id
        self.name = name
        self.code = code
        self.allowQuickBuy = allowQuickBuy
        self.defaultVariantArticle = defaultVariantArticle
        self.deliveryConditionsURL = deliveryConditionsURL
        self.$mainBanner.id = mainBannerID
        self.$sale.id = saleID
    }

}
