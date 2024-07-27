//
//  DeliveryTimeInterval.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor
import Fluent

extension Delivery {

    final class DeliveryTimeInterval: Model, Content, @unchecked Sendable {

        static let schema = "delivery_time_intervals"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "delivery_id")
        var delivery: Delivery

        @Field(key: "from")
        var from: String

        @Field(key: "to")
        var to: String

        init() {}

        init(id: UUID? = nil, deliveryID: Delivery.IDValue, from: String, to: String) {
            self.id = id
            self.$delivery.id = deliveryID
            self.from = from
            self.to = to
        }

    }

}
