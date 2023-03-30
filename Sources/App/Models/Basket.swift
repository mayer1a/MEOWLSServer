//
//  Basket.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - Basket

struct Basket: Content {
    var amount: Int
    var products_quantity: Int
    var products: [BasketElement]
}
