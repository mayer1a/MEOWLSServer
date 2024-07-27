//
//  CartResponse.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct CartResponse: Content {

    let id: UUID
    let items: [CartItemDTO]
    let promoCode: PromoCodeDTO?
    let itemsSummary: [SummaryDTO]?
    let total: SummaryDTO

    enum CodingKeys: String, CodingKey {
        case id, items
        case promoCode = "promo_code"
        case itemsSummary = "items_summary"
        case total
    }

}
