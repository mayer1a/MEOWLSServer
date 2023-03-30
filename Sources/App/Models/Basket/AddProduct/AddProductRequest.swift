//
//  AddProductRequest.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - AddProductRequest

struct AddProductRequest: Content {
    var user_id: Int
    var basket_element: BasketElement
}
