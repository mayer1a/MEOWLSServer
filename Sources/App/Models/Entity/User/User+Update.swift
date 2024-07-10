//
//  User+Update.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Vapor

extension User {

    struct Update: Content {
        var surname: String?
        var name: String?
        var patronymic: String?
        var birthday: Date?
        var gender: Gender?
        var email: String?
        var phone: String
        var password: String?
        var confirmPassword: String?
    }

}

extension User {

    func update(with newUser: User.Update) throws {
        surname = newUser.surname
        name = newUser.name
        patronymic = newUser.patronymic
        birthday = newUser.birthday
        gender = newUser.gender
        email = newUser.email
        phone = newUser.phone

        if let password = newUser.password {
            passwordHash = try Bcrypt.hash(password)
        }
    }

}
