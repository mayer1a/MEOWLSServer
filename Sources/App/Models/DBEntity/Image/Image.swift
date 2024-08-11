//
//  Image.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class Image: Model, Content, @unchecked Sendable {

    static let schema = "images"

    @ID(key: .id)
    var id: UUID?

    @Siblings(through: ProductImagePivot.self, from: \.$image, to: \.$product)
    var products: [Product]

    @OptionalParent(key: "category_id")
    var category: Category?

    @OptionalParent(key: "main_banner_id")
    var mainBanner: MainBanner?

    @OptionalParent(key: "sale_id")
    var sale: Sale?

    @OptionalField(key: "small")
    var small: String?

    @OptionalField(key: "medium")
    var medium: String?

    @OptionalField(key: "large")
    var large: String?

    @OptionalField(key: "original")
    var original: String?

    @OptionalChild(for: \.$image)
    var dimension: ImageDimension?

    var hasSize: Bool {
        small != nil || medium != nil || large != nil || original != nil
    }

    init() {}

    init(id: UUID? = nil,
         categoryID: Category.IDValue? = nil,
         mainBannerID: MainBanner.IDValue? = nil,
         saleID: Sale.IDValue? = nil,
         small: String?,
         medium: String?,
         large: String?,
         original: String?) {

        self.id = id
        self.$category.id = categoryID
        self.$mainBanner.id = mainBannerID
        self.$sale.id = saleID
        self.small = small
        self.medium = medium
        self.large = large
        self.original = original
    }

}
