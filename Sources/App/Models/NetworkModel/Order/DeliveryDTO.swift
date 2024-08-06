//
//  DeliveryDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct DeliveryDTO: Content {

    let type: DeliveryType
    let deliveryDate: String
    let deliveryTimeInterval: DeliveryTimeIntervalDTO
    let address: AddressDTO

    enum CodingKeys: String, CodingKey {
        case type
        case deliveryDate = "delivery_date"
        case deliveryTimeInterval = "delivery_time_interval"
        case address
    }

}
