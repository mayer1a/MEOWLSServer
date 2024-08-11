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

    @Parent(key: "product_id")
    var product: Product

    @OptionalParent(key: "cart_id")
    var cart: Cart?

    @OptionalParent(key: "order_id")
    var order: Order?

    @Field(key: "article")
    var article: String

    @Field(key: "count")
    var count: Int

    init() {}

    init(id: UUID? = nil,
         productID: Product.IDValue,
         cartID: Cart.IDValue? = nil,
         orderID: Order.IDValue? = nil,
         article: String,
         count: Int) {

        self.id = id
        self.$product.id = productID
        self.$cart.id = cartID
        self.$order.id = orderID
        self.article = article
        self.count = count
    }

}
