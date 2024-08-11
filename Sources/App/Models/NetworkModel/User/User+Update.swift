//
//  User+Update.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Vapor

extension User {

    struct UpdateDTO: Content {
        
        var surname: String?
        var name: String?
        var patronymic: String?
        var birthday: Date?
        var gender: Gender?
        var email: String?
        var phone: String
        var password: String?
        var confirmPassword: String?

        enum CodingKeys: String, CodingKey {
            case surname, name, patronymic, birthday, gender, email, phone, password
            case confirmPassword = "confirm_password"
        }
        
    }

}
