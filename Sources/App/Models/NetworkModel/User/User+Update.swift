//
//  User+Update.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Vapor

extension User {

    struct UpdateDTO: Content {
        
        let surname: String?
        let name: String?
        let patronymic: String?
        let birthday: Date?
        let gender: Gender?
        let email: String?
        let phone: String
        let password: String?
        let confirmPassword: String?

        enum CodingKeys: String, CodingKey {
            case surname, name, patronymic, birthday, gender, email, phone, password
            case confirmPassword = "confirm_password"
        }
        
    }

}
