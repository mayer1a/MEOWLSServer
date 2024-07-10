//
//  CartRequest.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - CartRequest

struct CartRequest: Content {
    var user_id: Int
}

