//
//  CartItemDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct CartItemDTO: Content {

    let id: UUID
    let productID: UUID
    let article: String
    let productName: String
    let availabilityInfo: AvailabilityInfoDTO
    let count: Int
    let price: PriceDTO
    let image: ImageDTO?
    let variantName: String?
    let badges: [BadgeDTO]?
    let amount: PriceDTO

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case article
        case productName = "product_name"
        case availabilityInfo = "availability_info"
        case count, price, image
        case variantName = "variant_name"
        case badges, amount
    }

}
