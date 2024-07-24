//
//  BadgeDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO.ProductVariantDTO {

    struct BadgeDTO: Content {

        let id: UUID
        let title: String
        let text: String?
        let backgroundColor: HEXColor
        let tintColor: HEXColor

        enum CodingKeys: String, CodingKey {
            case id
            case title, text
            case backgroundColor = "background_color"
            case tintColor = "tint_color"
        }

    }

}
