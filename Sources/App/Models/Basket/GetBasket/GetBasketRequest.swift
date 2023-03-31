//
//  GetBasketRequest.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - GetBasketRequest

struct GetBasketRequest: Content {
    var user_id: Int
}

