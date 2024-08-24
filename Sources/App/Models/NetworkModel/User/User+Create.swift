//
//  User+Create.swift
//  
//
//  Created by Artem Mayer on 28.06.2024.
//

import Vapor

extension User {

    struct CreateDTO: Content {

        let surname: String?
        let name: String?
        let patronymic: String?
        let birthday: Date?
        let gender: Gender?
        let email: String?
        let phone: String
        let password: String
        let confirmPassword: String

        enum CodingKeys: String, CodingKey {
            case surname, name, patronymic, birthday, gender, email, phone, password
            case confirmPassword = "confirm_password"
        }
        
    }

}

extension User.CreateDTO {

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
