//
//  EditProductResponse.swift
//  
//
//  Created by Artem Mayer on 29.03.2023.
//

import Vapor

// MARK: - EditProductResponse

struct EditProductResponse: Content {
    var result: Int
    var error_message: String?
}
