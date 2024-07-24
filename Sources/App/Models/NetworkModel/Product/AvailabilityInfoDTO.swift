//
//  AvailabilityInfoDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO.ProductVariantDTO {

    struct AvailabilityInfoDTO: Content {

        let id: UUID
        let type: AvailabilityInfo.AvailabilityType
        let deliveryDuration: Int?
        let count: Int

        enum CodingKeys: String, CodingKey {
            case id, type
            case deliveryDuration = "delivery_duration"
            case count
        }

    }

}
