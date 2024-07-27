//
//  City.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor
import Fluent

extension Address {

    final class City: Model, Content, @unchecked Sendable {

        static let schema = "cities"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "address_id")
        var address: Address

        @Field(key: "name")
        var name: String

        @Field(key: "fias_id")
        var fiasID: String

        init() {}

        init(id: UUID? = nil, addressID: Address.IDValue, name: String, fiasID: String) {
            self.id = id
            self.$address.id = addressID
            self.name = name
            self.fiasID = fiasID
        }

    }

}
