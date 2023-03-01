//
//  GetCatalogResponse.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetCatalogResponse

struct GetCatalogResponse: Content {
    var result: Int
    var page_number: Int?
    var products: [Product]?
    var error_message: String?
}
