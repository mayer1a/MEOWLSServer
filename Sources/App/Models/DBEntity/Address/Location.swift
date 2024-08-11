//
//  Location.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor
import Fluent

extension Address {

    final class Location: Model, Content, @unchecked Sendable {

        static let schema = "locations"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "address_id")
        var address: Address

        @Field(key: "latitude")
        var latitude: Double

        @Field(key: "longitude")
        var longitude: Double

        init() {}

        init(id: UUID? = nil, addressID: Address.IDValue, latitude: Double, longitude: Double) {
            self.id = id
            self.$address.id = addressID
            self.latitude = latitude
            self.longitude = longitude
        }

    }

}
