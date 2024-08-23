//
//  AvailableDeliveryDTO.swift
//
//
//  Created by Artem Mayer on 18.08.2024.
//

import Vapor

struct AvailableDeliveryDTO: Content {

    let type: DeliveryType
    let title: String
    let subtitle: String

}
