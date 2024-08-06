//
//  PromoCodeResponse.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor

struct PromoCodeDTO: Content {

    let code: String?
    let discount: Int
    let discountType: DiscountType
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case code
        case discount
        case discountType = "discount_type"
        case isActive = "is_active"
    }

}
