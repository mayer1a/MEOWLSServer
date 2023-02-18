//
//  GetProductRequest.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

struct GetProductRequest: Content {
    var product_id: Int
}
