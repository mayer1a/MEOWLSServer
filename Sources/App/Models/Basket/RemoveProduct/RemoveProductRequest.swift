//
//  RemoveProductRequest.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - RemoveProductRequest

struct RemoveProductRequest: Content {
    var user_id: Int
    var product_id: Int
}
