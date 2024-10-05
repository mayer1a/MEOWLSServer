//
//  User+Public.swift
//  
//
//  Created by Artem Mayer on 29.06.2024.
//

import Vapor

extension User {

    struct PublicDTO: Content {

        let id: UUID?
        let surname: String?
        let name: String?
        let patronymic: String?
        let birthday: Date?
        let gender: Gender?
        let email: String?
        let phone: String
        let authentication: Authentication?
        let favoriteItems: [UUID]?

        enum CodingKeys: String, CodingKey {
            case id, surname, name, patronymic, birthday, gender, email, phone, authentication
            case favoriteItems = "favorite_items"
        }

    }

}
