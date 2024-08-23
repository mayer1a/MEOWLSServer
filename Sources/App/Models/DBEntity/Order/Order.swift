//
//  Order.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class Order: Model, Content, @unchecked Sendable {

    static let schema = "orders"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "user_id")
    var user: User

    @Field(key: "number")
    var number: Int

    @Enum(key: "status_code")
    var statusCode: StatusCode

    @Field(key: "status")
    var status: String

    @Boolean(key: "can_be_paid_online")
    var canBePaidOnline: Bool

    @Boolean(key: "paid")
    var paid: Bool

    @Field(key: "order_date")
    var orderDate: Date

    @OptionalChild(for: \.$order)
    var delivery: Delivery?

    @OptionalField(key: "comment")
    var comment: String?

    @Enum(key: "payment_type")
    var paymentType: PaymentType
    
    @Children(for: \.$order)
    var items: [CartItem]
    
    @Children(for: \.$order)
    var summaries: [Summary]

    init() {}

    init(id: UUID? = nil,
         userID: User.IDValue,
         statusCode: StatusCode,
         status: String,
         canBePaidOnline: Bool,
         paid: Bool,
         orderDate: Date,
         comment: String?,
         paymentType: PaymentType) {

        self.id = id
        self.$user.id = userID
        self.statusCode = statusCode
        self.status = status
        self.canBePaidOnline = canBePaidOnline
        self.paid = paid
        self.orderDate = orderDate
        self.comment = comment
        self.paymentType = paymentType
    }

}

