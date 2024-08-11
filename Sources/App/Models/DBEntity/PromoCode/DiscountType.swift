//
//  DiscountType.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor

extension PromoCode {

    enum DiscountType: String, Content {
        
        case fixedAmount = "fixed_amount"
        case percent
        
    }

}
