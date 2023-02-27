//
//  GetCatalogRequest.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetCatalogRequest

struct GetCatalogRequest: Content {
    var page_number: Int
    var category_id: Int
}
