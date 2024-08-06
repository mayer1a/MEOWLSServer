//
//  AvailabilityInfoDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductVariantDTO {

    struct AvailabilityInfoDTO: Content {

        let type: AvailabilityType
        let deliveryDuration: Int?
        let count: Int

        enum CodingKeys: String, CodingKey {
            case type
            case deliveryDuration = "delivery_duration"
            case count
        }

    }

}
