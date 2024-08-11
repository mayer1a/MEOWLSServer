//
//  CartResponse.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct CartDTO: Content {

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

    init(id: UUID, 
         items: [CartItemDTO], 
         promoCode: PromoCodeDTO? = nil,
         itemsSummary: [SummaryDTO]? = nil,
         total: SummaryDTO = .init()) {

        self.id = id
        self.items = items
        self.promoCode = promoCode
        self.itemsSummary = itemsSummary
        self.total = total
    }

}
