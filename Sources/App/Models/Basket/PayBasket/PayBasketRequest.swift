//
//  PayBasketRequest.swift
//  
//
//  Created by Artem Mayer on 29.03.2023.
//

import Vapor

// MARK: - PayBasketRequest

struct PayBasketRequest: Content {
    var user_id: Int
}
