//
//  RemoveProductResponse.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - RemoveProductResponse

struct RemoveProductResponse: Content {
    var result: Int
    var error_message: String?
}
