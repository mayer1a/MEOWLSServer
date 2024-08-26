//
//  SaleDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct SaleDTO: Content {

    let id: UUID
    let code: String
    let saleType: SaleType
    let title: String
    let image: ImageDTO?
    let startDate: Date
    let endDate: Date
    let disclaimer: String
    let products: [ProductDTO]?

    enum CodingKeys: String, CodingKey {
        case id, code
        case saleType = "sale_type"
        case title, image
        case startDate = "start_date"
        case endDate = "end_date"
        case disclaimer, products
    }

}
