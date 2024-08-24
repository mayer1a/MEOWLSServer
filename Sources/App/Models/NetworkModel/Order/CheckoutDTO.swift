//
//  CheckoutDTO.swift
//
//
//  Created by Artem Mayer on 18.08.2024.
//

import Vapor

struct CheckoutDTO: Content {

    let comment: String?
    let client: CheckoutClientDTO?
    let delivery: DeliveryDTO
    let paymentType: PaymentType?

    enum CodingKeys: String, CodingKey {
        case comment, client, delivery
        case paymentType = "payment_type"
    }

}

struct CheckoutClientDTO: Content {
    
    let surname: String?
    let name: String?
    let patronymic: String?
    let email: String?
    let phone: String

}
