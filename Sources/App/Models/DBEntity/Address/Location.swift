//
//  Location.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor
import Fluent

final class Location: Model, Content, @unchecked Sendable, Coordinatable {

    static let schema = "locations"

    @ID(key: .id)
    var id: UUID?

    @OptionalParent(key: "address_id")
    var address: Address?

    @OptionalParent(key: "city_id")
    var city: City?

    @Field(key: "latitude")
    var latitude: Double

    @Field(key: "longitude")
    var longitude: Double

    init() {}

    init(id: UUID? = nil, addressID: Address.IDValue? = nil, cityID: City.IDValue? = nil, latitude: Double, longitude: Double) {
        self.id = id
        self.$address.id = addressID
        self.$city.id = cityID
        self.latitude = latitude
        self.longitude = longitude
    }

}

