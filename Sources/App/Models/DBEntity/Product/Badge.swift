//
//  Badge.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class Badge: Model, Content, @unchecked Sendable {
    
    static let schema = "badges"

    @ID(key: .id)
    var id: UUID?

    @Siblings(through: ProductVariantBadgePivot.self, from: \.$badge, to: \.$productVariant)
    var productsVariants: [ProductVariant]

    @Field(key: "title")
    var title: String

    @OptionalField(key: "text")
    var text: String?

    @Field(key: "background_color")
    var backgroundColor: HEXColor

    @Field(key: "tint_color")
    var tintColor: HEXColor

    enum CodingKeys: String, CodingKey {
        case title, icon, text
        case backgroundColor = "background_color"
        case tintColor = "tint_color"
    }

    init() {}

    init(id: UUID? = nil, title: String, text: String?, backgroundColor: HEXColor, tintColor: HEXColor) {
        self.id = id
        self.title = title
        self.text = text
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }

}
