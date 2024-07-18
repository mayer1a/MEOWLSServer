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

    init() {}

    init(id: UUID? = nil,
         categoryID: Category.IDValue?,
         small: String?,
         medium: String?,
         large: String?,
         original: String?) {

        self.id = id
        self.$category.id = categoryID
        self.small = small
        self.medium = medium
        self.large = large
        self.original = original
    }

}
