//
//  AddProductResponse.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - AddProductResponse

struct AddProductResponse: Content {
    var result: Int
    var error_message: String?
}
