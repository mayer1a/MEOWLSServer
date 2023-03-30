//
//  EditProductRequest.swift
//  
//
//  Created by Artem Mayer on 29.03.2023.
//

import Vapor

// MARK: - EditProductRequest

struct EditProductRequest: Content {
    var user_id: Int
    var product_id: Int
    var new_quantity: Int
}
