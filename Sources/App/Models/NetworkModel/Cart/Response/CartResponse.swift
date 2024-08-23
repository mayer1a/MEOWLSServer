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
    let summaries: [SummaryDTO]?
    let availabilityAlertMessage: String?
    let save: Bool?

    enum CodingKeys: String, CodingKey {
        case id, items
        case promoCode = "promo_code"
        case summaries
        case availabilityAlertMessage = "availability_alert_message"
        case save
    }

    init(id: UUID, 
         items: [CartItemDTO], 
         promoCode: PromoCodeDTO? = nil,
         summaries: [SummaryDTO]? = nil,
         availabilityAlertMessage: String? = nil,
         save: Bool? = nil) {

        self.id = id
        self.items = items
        self.promoCode = promoCode
        self.summaries = summaries
        self.availabilityAlertMessage = availabilityAlertMessage
        self.save = save
    }

}
