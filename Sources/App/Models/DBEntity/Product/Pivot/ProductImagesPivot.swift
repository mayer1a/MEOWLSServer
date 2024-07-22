//
//  ProductImagesPivot.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class ProductImagePivot: Model, @unchecked Sendable {

    static let schema = "products+images"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_id")
    var product: Product

    @Parent(key: "image_id")
    var image: Image

    init() {}

    init(id: UUID? = nil, product: Product, image: Image) throws {
        self.id = id
        self.$product.id = try product.requireID()
        self.$image.id = try image.requireID()
    }

}
