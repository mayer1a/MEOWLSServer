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

    @Field(key: "product_id")
    var productID: UUID

    @Field(key: "count")
    var count: Int

    @OptionalChild(for: \.$cartItem)
    var amount: Price?

    init() {}

}


// ADD REFERENCE FOR PRICE TABLE TO CART ITEM ID !!!!
