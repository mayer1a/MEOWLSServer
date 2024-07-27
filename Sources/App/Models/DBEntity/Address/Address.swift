//
//  Address.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor
import Fluent

final class Address: Model, Content, @unchecked Sendable {

    static let schema = "addresses"

    @ID(key: .id)
    var id: UUID?

    @OptionalParent(key: "delivery_id")
    var delivery: Delivery?

    @OptionalParent(key: "user_id")
    var user: User?

    @Field(key: "street")
    var street: String

    @Field(key: "house")
    var house: String

    @OptionalField(key: "entrance")
    var entrance: String?

    @OptionalField(key: "floor")
    var floor: String?

    @OptionalField(key: "flat")
    var flat: String?

    @Field(key: "formatted_string")
    var formattedString: String

    @OptionalChild(for: \.$address)
    var city: City?

    @OptionalChild(for: \.$address)
    var location: Location?

    init() {}

    init(id: UUID? = nil,
         deliveryID: Delivery.IDValue? = nil,
         userID: User.IDValue? = nil,
         street: String,
         house: String,
         entrance: String?,
         floor: String?,
         flat: String?,
         formattedString: String) {

        self.id = id
        self.$delivery.id = deliveryID
        self.$user.id = userID
        self.street = street
        self.house = house
        self.entrance = entrance
        self.floor = floor
        self.flat = flat
        self.formattedString = formattedString
    }

}
