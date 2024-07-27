//
//  CartItem.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor
import Fluent

final class CartItem: Model, @unchecked Sendable {

    static let schema = "cart_items"

    @ID(key: .id)
    var id: UUID?

    @OptionalParent(key: "cart_id")
    var cart: Cart?

    @OptionalParent(key: "order_id")
    var order: Order?

    @Field(key: "product_id")
    var productID: UUID

    @Field(key: "count")
    var count: Int

    @OptionalChild(for: \.$cartItem)
    var amount: Price?

    init() {}

    init(id: UUID? = nil, cartID: Cart.IDValue? = nil, orderID: Order.IDValue? = nil, productID: UUID, count: Int) {
        self.id = id
        self.$cart.id = cartID
        self.$order.id = orderID
        self.productID = productID
        self.count = count
    }

}


// ADD REFERENCE FOR PRICE TABLE TO CART ITEM ID !!!!
