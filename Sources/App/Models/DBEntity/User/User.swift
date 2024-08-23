//
//  User.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor
import Fluent

// MARK: - User

final class User: Model, Content, @unchecked Sendable {

    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @OptionalField(key: "surname")
    var surname: String?

    @OptionalField(key: "name")
    var name: String?

    @OptionalField(key: "patronymic")
    var patronymic: String?

    @OptionalField(key: "birthday")
    var birthday: Date?

    @OptionalEnum(key: "gender")
    var gender: Gender?

    @OptionalField(key: "email")
    var email: String?

    @Field(key: "password_hash")
    var passwordHash: String

    @Field(key: "phone")
    var phone: String

    @OptionalChild(for: \.$user)
    var token: Token?

    @Enum(key: "role")
    var role: UserRole

    @OptionalChild(for: \.$user)
    var favorites: Favorites?

    @Children(for: \.$user)
    var orders: [Order]

    @OptionalChild(for: \.$user)
    var cart: Cart?

    @Siblings(through: PromoCodesUsersPivot.self, from: \.$user, to: \.$promoCode)
    var usedPromoCodes: [PromoCode]

    @OptionalChild(for: \.$user)
    var address: Address?

    init() {}

    init(id: UUID? = nil,
         surname: String? = nil,
         name: String? = nil,
         patronymic: String? = nil,
         birthday: Date? = nil,
         gender: Gender? = nil,
         email: String? = nil,
         passwordHash: String = "",
         phone: String = "",
         role: UserRole) {

        self.id = id
        self.surname = surname
        self.name = name
        self.patronymic = patronymic
        self.birthday = birthday
        self.gender = gender
        self.email = email
        self.passwordHash = passwordHash
        self.phone = phone
        self.role = role
    }

}

extension User: ModelAuthenticatable {

    static let usernameKey = \User.$phone
    static let passwordHashKey = \User.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }

}

