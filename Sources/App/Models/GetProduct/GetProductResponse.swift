//
//  GetProductResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - DetailedProductInfo

struct DetailedProduct: Content {
    var product_description: String
    var images: [String]
}

// MARK: - GetProductResponse

struct GetProductResponse: Content {
    var result: Int
    var product: DetailedProduct?
    var error_message: String?
}
