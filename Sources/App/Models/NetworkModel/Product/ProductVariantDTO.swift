//
//  ProductVariantDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO {

    struct ProductVariantDTO: Content {

        let id: UUID
        let article: String
        let shortName: String
        let price: PriceDTO?
        let availabilityInfo: AvailabilityInfoDTO?
        let badges: [BadgeDTO]
        let propertyValues: [PropertyValueDTO]

        enum CodingKeys: String, CodingKey {
            case id, article
            case shortName = "short_name"
            case price
            case availabilityInfo = "availability_info"
            case badges
            case propertyValues = "property_values"
        }

    }

}
