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

    @Field(key: "small")
    var small: String?

    @Field(key: "medium")
    var medium: String?

    @Field(key: "large")
    var large: String?

    @Field(key: "original")
    var original: String?

    @OptionalChild(for: \.$image)
    var dimension: ImageDimension?

    init() {}

    init(id: UUID? = nil,
         small: String?,
         medium: String?,
         large: String?,
         original: String?) {

        self.id = id
        self.small = small
        self.medium = medium
        self.large = large
        self.original = original
    }

}
