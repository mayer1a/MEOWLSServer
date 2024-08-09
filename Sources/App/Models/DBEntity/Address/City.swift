//
//  City.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor
import Fluent

final class City: Model, Content, @unchecked Sendable {

    static let schema = "cities"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "region_id")
    var region: Region

    @Field(key: "name")
    var name: String

    @Children(for: \.$city)
    var addresses: [Address]

    init() {}

    init(id: UUID? = nil, regionID: Region.IDValue, name: String) {
        self.id = id
        self.$region.id = regionID
        self.name = name
    }

}
