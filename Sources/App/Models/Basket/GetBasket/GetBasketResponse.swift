//
//  GetBasketResponse.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - GetBasketResponse

struct GetBasketResponse: Content {
    var result: Int
    var basket: Basket?
    var error_message: String?
}
