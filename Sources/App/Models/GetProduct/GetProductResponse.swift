//
//  GetProductResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetProductResponse

struct GetProductResponse: Content {
    var result: Int
    var product: DetailedProduct?
    var error_message: String?
}
