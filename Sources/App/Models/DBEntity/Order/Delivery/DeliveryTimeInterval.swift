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

        @Children(for: \.$deliveryTimeInterval)
        var deliveries: [Delivery]

        @Field(key: "from")
        var from: String

        @Field(key: "to")
        var to: String

        init() {}

        init(id: UUID? = nil, from: String, to: String) {
            self.id = id
            self.from = from
            self.to = to
        }

    }

}
