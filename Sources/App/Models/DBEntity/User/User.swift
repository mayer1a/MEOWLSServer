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

    @Field(key: "surname")
    var surname: String?

    @Field(key: "name")
    var name: String?

    @Field(key: "patronymic")
    var patronymic: String?

    @Field(key: "birthday")
    var birthday: Date?

    @OptionalEnum(key: "gender")
    var gender: Gender?

    @Field(key: "email")
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

    @Siblings(through: PromoCodesUsersPivot.self, from: \.$user, to: \.$promoCode)
    var usedPromoCodes: [PromoCode]

    init() {}

    init(id: UUID? = nil,
         surname: String?,
         name: String?,
         patronymic: String?,
         birthday: Date?,
         gender: Gender?,
         email: String?,
         passwordHash: String,
         phone: String,
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

    func convertToPublic(with token: Token? = nil) async throws -> User.PublicDTO {
        User.PublicDTO(id: id,
                       surname: surname,
                       name: name,
                       patronymic: patronymic,
                       birthday: birthday,
                       gender: gender,
                       email: email,
                       phone: phone,
                       token: token?.value,
                       role: role)
    }

}

