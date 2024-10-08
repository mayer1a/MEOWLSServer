//
//  DeliveryTimeIntervalDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

extension DeliveryDTO {

    struct DeliveryTimeIntervalDTO: Content {

        let id: UUID
        let from: String
        let to: String

    }

}
