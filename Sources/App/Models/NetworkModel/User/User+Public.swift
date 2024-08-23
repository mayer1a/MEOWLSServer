//
//  User+Public.swift
//  
//
//  Created by Artem Mayer on 29.06.2024.
//

import Vapor

extension User {

    struct PublicDTO: Content {

        var id: UUID?
        var surname: String?
        var name: String?
        var patronymic: String?
        var birthday: Date?
        var gender: Gender?
        var email: String?
        var phone: String
        var token: String?

        init(id: UUID? = nil,
             surname: String?,
             name: String?,
             patronymic: String?,
             birthday: Date? = nil,
             gender: Gender? = nil,
             email: String?,
             phone: String,
             token: String? = nil) {
            
            self.id = id
            self.surname = surname
            self.name = name
            self.patronymic = patronymic
            self.birthday = birthday
            self.gender = gender
            self.email = email
            self.phone = phone
            self.token = token
        }

    }

}
