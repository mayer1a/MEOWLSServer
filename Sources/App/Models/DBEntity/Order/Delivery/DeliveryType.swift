//
//  DeliveryType.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

extension Delivery {

    enum DeliveryType: String, Content {
        case courier
        case selfPickup = "self_pickup"
    }

}
