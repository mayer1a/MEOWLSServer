//
//  GetProductRequest.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetProductRequest

struct GetProductRequest: Content {
    var product_id: Int
}
