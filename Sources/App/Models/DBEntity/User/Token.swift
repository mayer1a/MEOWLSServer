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
    /// 1 day (24 hours)
    static private let tokenLifeTime: TimeInterval = 86_400
    /// 30 days including 24 hours (token life time)
    static private let tokenRefreshableLifeTime: TimeInterval = 2_505_600

    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Field(key: "expired")
    var expired: Date

    @Parent(key: "user_id")
    var user: User

    var tokenFormatValue: String {
        "Token \(value)"
    }

    init() {}

    init(id: UUID? = nil, value: String, expired: Date, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.expired = expired
        self.$user.id = userID
    }

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

    var canRefreshable: Bool {
        Date.now < expired.addingTimeInterval(Token.tokenRefreshableLifeTime)
    }

}
