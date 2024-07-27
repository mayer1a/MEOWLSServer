//
//  Summary.swift
//  
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor
import Fluent

final class Summary: Model, @unchecked Sendable {

    static let schema = "summaries"

    @ID(key: .id)
    var id: UUID?

    @OptionalParent(key: "cart_id")
    var cart: Cart?

    @OptionalParent(key: "order_id")
    var order: Order?

    @Field(key: "name")
    var name: String

    @Field(key: "value")
    var value: Double

    init() {}

    init(id: UUID? = nil, cartID: Cart.IDValue? = nil, orderID: Order.IDValue? = nil, name: String, value: Double) {
        self.id = id
        self.$cart.id = cartID
        self.$order.id = orderID
        self.name = name
        self.value = value
    }

}
