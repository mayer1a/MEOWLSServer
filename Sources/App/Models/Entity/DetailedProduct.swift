//
//  DetailedProduct.swift
//  
//
//  Created by Artem Mayer on 28.03.2023.
//

import Vapor

// MARK: - DetailedProduct

struct DetailedProduct: Content {
    var product_description: String
    var images: [String]
}
