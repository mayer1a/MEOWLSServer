//
//  Image+ImageDimension.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

extension Image {

    final class ImageDimension: Model, Content, @unchecked Sendable {

        static let schema = "image_dimensions"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "image_id")
        var image: Image

        @Field(key: "width")
        var width: Int

        @Field(key: "height")
        var height: Int

        init() {}

        init(id: UUID? = nil, image: Image.IDValue, width: Int, height: Int) {
            self.id = id
            self.$image.id = image
            self.width = width
            self.height = height
        }

    }

}
