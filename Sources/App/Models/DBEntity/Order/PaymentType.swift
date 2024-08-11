//
//  PaymentType.swift
//  
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor

extension Order {

    enum PaymentType: String, Content {
        
        case card
        case cash
        
    }

}
