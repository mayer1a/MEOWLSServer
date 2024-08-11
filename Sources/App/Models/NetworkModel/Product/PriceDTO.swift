//
//  PriceDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductVariantDTO {

    struct PriceDTO: Content {

        var originalPrice: Double
        let discount: Double?
        var price: Double

        enum CodingKeys: String, CodingKey {
            case originalPrice = "original_price"
            case discount, price
        }

    }

}
