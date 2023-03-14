//
//  RawUpdateUserModel.swift
//
//
//  Created by Artem Mayer on 13.03.2023.
//

import Vapor

final class RawUpdateUserModel: Content {
    var user_id: Int
    var name: String
    var lastname: String
    var username: String
    var email: String
    var credit_card: String
    var gender: Gender
    var bio: String

    init() {
        user_id = 0
        name = ""
        lastname = ""
        username = ""
        email = ""
        credit_card = ""
        gender = .indeterminate
        bio = ""
    }

    private init(
        user_id: Int,
        name: String,
        lastname: String,
        username: String,
        email: String,
        credit_card: String,
        gender: Gender,
        bio: String
    ) {
        self.user_id = user_id
        self.name = name
        self.lastname = lastname
        self.username = username
        self.email = email
        self.credit_card = credit_card
        self.gender = gender
        self.bio = bio
    }
}


