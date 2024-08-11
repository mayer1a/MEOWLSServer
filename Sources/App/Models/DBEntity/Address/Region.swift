//
//  Region.swift
//
//
//  Created by Artem Mayer on 08.08.2024.
//

import Vapor
import Fluent

final class Region: Model, Content, @unchecked Sendable {

    static let schema = "regions"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Children(for: \.$region)
    var cities: [City]

    init() {}

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }

}
