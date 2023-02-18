//
//  GetCatalogResponse.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - ProductMainInfo

struct ProductMainInfo: Content {
    var product_id: Int
    var product_name: String
    var product_price: Int
}

// MARK: - GetCatalogResponse

struct GetCatalogResponse: Content {
    var result: Int
    var page_number: Int?
    var products: [ProductMainInfo]?
    var error_message: String?
}
