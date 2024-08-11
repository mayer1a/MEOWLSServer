//
//  CartRequest.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct CartRequest: Content {

    let cart: CartDTO
    let promoCode: PromoCodeRequest?

}
