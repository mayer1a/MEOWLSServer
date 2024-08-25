//
//  AvailablePaymentsDTO.swift
//  
//
//  Created by Artem Mayer on 20.08.2024.
//

import Vapor

struct AvailablePaymentsDTO: Content {

    let type: Order.PaymentType
    let title: String
    let subtitle: String

}
