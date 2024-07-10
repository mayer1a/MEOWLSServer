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
    var email: String

    @Field(key: "password")
    var password: String

    @Field(key: "phone")
    var phone: String?

    @OptionalChild(for: \.$user)
    var token: Token?

    @Field(key: "credit_card")
    var credit_card: String?

    init(id: UUID,
         surname: String?,
         name: String?,
         patronymic: String?,
         birthday: Date?,
         gender: Gender?,
         email: String,
         password: String,
         phone: String?,
         credit_card: String?) {

        self.id = id
        self.surname = surname
        self.name = name
        self.patronymic = patronymic
        self.birthday = birthday
        self.gender = gender
        self.email = email
        self.password = password
        self.phone = phone
        self.credit_card = credit_card
    }

    init() {}

    final class Public: Content {

        var id: UUID?
        var surname: String?
        var name: String?
        var patronymic: String?
        var birthday: Date?
        var gender: Gender?
        var email: String?
        var phone: String?
        var token: String?
        var credit_card: String?

        init(id: UUID?,
             surname: String?,
             name: String?,
             patronymic: String?,
             birthday: Date?,
             gender: Gender?,
             email: String?,
             phone: String?,
             token: String?,
             credit_card: String?) {

            self.id = id
            self.surname = surname
            self.name = name
            self.patronymic = patronymic
            self.birthday = birthday
            self.gender = gender
            self.email = email
            self.phone = phone
            self.token = token
            self.credit_card = credit_card
        }

    }

}

extension User: Equatable {

    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    static func ==(lhs: User, rhs: EditProfileRequest) -> Bool {
        lhs.id == rhs.id
    }

    static func ==(lhs: User, rhs: SignUpRequest) -> Bool {
        lhs.phone == rhs.phone || lhs.email == rhs.email
    }

}

extension User: ModelAuthenticatable {    

    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$password

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }

    func convertToPublic(_ database: Database) async throws -> User.Public {
        let token = try await Token.query(on: database).filter(\.$user.$id == requireID()).first()?.value

        print("[TOKEN] \(self.$token.value??.value)")
        return User.Public(id: id,
                           surname: surname, 
                           name: name,
                           patronymic: patronymic,
                           birthday: birthday,
                           gender: gender,
                           email: email,
                           phone: phone,
                           token: token,
                           credit_card: credit_card)
    }

}
