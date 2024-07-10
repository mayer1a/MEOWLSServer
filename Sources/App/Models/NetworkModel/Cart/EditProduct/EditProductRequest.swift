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
    var basket_element: CartItem
}
