//
//  PriceDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO.ProductVariantDTO {

    struct PriceDTO: Content {

        let originalPrice: Double
        let discount: Double?
        let price: Double

        enum CodingKeys: String, CodingKey {
            case originalPrice = "original_price"
            case discount, price
        }

    }

}
