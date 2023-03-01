//
//  PayBasketResponse.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - PayBasketResponse

struct PayBasketResponse: Content {
    var result: Int
    var user_message: String?
    var error_message: String?
}
