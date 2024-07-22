//
//  User+Create.swift
//  
//
//  Created by Artem Mayer on 28.06.2024.
//

import Vapor

extension User {

    struct Create: Content {
        var surname: String?
        var name: String?
        var patronymic: String?
        var birthday: Date?
        var gender: Gender?
        var email: String?
        var phone: String
        var password: String
        var confirmPassword: String

        enum CodingKeys: String, CodingKey {
            case surname, name, patronymic, birthday, gender, email, phone, password
            case confirmPassword = "confirm_password"
        }
    }

}

extension User.Create {

    func toUser(with role: UserRole) throws -> User {
        try User(surname: surname,
                 name: name,
                 patronymic: patronymic,
                 birthday: birthday,
                 gender: gender,
                 email: email,
                 passwordHash: Bcrypt.hash(password),
                 phone: phone,
                 role: role)
    }

}
