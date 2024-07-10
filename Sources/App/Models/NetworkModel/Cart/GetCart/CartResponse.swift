//
//  CartResponse.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - CartResponse

struct CartResponse: Content {
    var result: Int
    var cart: Cart?
    var error_message: String?
}
