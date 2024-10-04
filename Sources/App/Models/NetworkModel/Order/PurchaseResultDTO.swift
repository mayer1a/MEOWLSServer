//
//  PurchaseResultDTO.swift
//
//
//  Created by Artem Mayer on 20.08.2024.
//

import Vapor

struct PurchaseResultDTO: Content {

    let orderNumber: String

    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
    }

}
