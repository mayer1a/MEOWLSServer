//
//  Cart.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - Basket

struct Cart: Content {
    var amount: Int
    var products_quantity: Int
    var products: [CartItem]
}
