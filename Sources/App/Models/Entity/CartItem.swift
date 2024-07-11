//
//  CartItem.swift
//
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - CartItem

struct CartItem: Content {
    var product: _Product
    var quantity: Int
}
