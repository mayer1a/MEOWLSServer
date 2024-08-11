//
//  Delivery.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor
import Fluent

final class Delivery: Model, Content, @unchecked Sendable {

    static let schema = "deliveries"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "order_id")
    var order: Order

    @Enum(key: "type")
    var type: DeliveryType

    @OptionalField(key: "delivery_date")
    var deliveryDate: Date?

    @OptionalChild(for: \.$delivery)
    var deliveryTimeInterval: DeliveryTimeInterval?

    @OptionalChild(for: \.$delivery)
    var address: Address?

    init() {}

    init(id: UUID? = nil, orderID: Order.IDValue, type: DeliveryType, deliveryDate: Date?) {
        self.id = id
        self.$order.id = orderID
        self.type = type
        self.deliveryDate = deliveryDate
    }

}
