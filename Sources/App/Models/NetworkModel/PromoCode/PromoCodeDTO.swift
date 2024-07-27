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
    let discountType: PromoCode.DiscountType
    let isActive: Bool

}
