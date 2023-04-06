//
//  BasketElement.swift
//  
//
//  Created by Artem Mayer on 30.03.2023.
//

import Vapor

// MARK: - BasketElement

struct BasketElement: Content {
    var product: Product
    var quantity: Int
}
