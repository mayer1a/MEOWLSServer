//
//  Product.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - ProductMainInfo

struct Product: Content {
    var product_id: Int
    var product_name: String
    var product_category: String
    var product_price: Int
    var product_main_image: String
}
