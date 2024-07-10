//
//  Token.swift
//  
//
//  Created by Artem Mayer on 21.06.2024.
//

import Vapor
import Fluent

final class Token: Model, Content, @unchecked Sendable {

    static let schema = "tokens"
    static private let tokenLifeTime: TimeInterval = 604800

    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Field(key: "expired")
    var expired: Date

    @Parent(key: "userID")
    var user: User

    init(id: UUID? = nil, value: String, expired: Date, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.expired = expired
        self.$user.id = userID
    }

    init() {}

}

extension Token {

    static func generate(for user: User) throws -> Token {
        let value = [UInt8].random(count: 32).base64
        return try Token(value: value, expired: Date.now + tokenLifeTime, userID: user.requireID())
    }

}

extension Token: ModelCustomTokenAuthenticatable {

    static let valueKey = \Token.$value
    static let userKey = \Token.$user

    var isValid: Bool {
        Date.now < expired
    }

}
