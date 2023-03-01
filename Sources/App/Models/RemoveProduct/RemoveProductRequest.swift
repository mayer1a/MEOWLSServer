//
//  RemoveProductRequest.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - RemoveProductRequest

struct RemoveProductRequest: Content {
    var product_id: Int
}
