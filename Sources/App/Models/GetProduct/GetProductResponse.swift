//
//  GetProductResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - DetailedProductInfo

struct DetailedProductInfo: Content {
    var product_name: String
    var product_price: Int
    var product_description: String
}

// MARK: - GetProductResponse

struct GetProductResponse: Content {
    var result: Int
    var product: DetailedProductInfo?
    var error_message: String?
}
