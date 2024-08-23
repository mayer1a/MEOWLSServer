//
//  OrderDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct OrderDTO: Content {

    let id: UUID
    let number: Int
    let statusCode: StatusCode
    let status: String
    let canBePaidOnline: Bool
    let paid: Bool
    let orderDate: String
    let cancelable: Bool
    let repeatAllowed: Bool
    let client: User.PublicDTO?
    let delivery: DeliveryDTO?
    let comment: String?
    let paymentType: PaymentType?
    let items: [CartItemDTO]?
    let summaries: [SummaryDTO]?
    let itemsPreviews: [Preview]?

    enum CodingKeys: String, CodingKey {
        case id, number
        case statusCode = "status_code"
        case status
        case canBePaidOnline = "can_be_paid_online"
        case paid
        case orderDate = "order_date"
        case cancelable
        case repeatAllowed = "repeat_allowed"
        case client, delivery, comment
        case paymentType = "payment_type"
        case items, summaries
        case itemsPreviews = "items_previews"
    }

}

extension OrderDTO {

    struct Preview: Content {
        let id: UUID
        let image: ImageDTO?
    }

}
