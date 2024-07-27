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


    @Field(key: "name")
    var name: String

    @Field(key: "value")
    var value: Double

    init() {}

}
