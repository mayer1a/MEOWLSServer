//
//  User.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - User

struct User: Content {
    var user_id: Int
    var username: String
    var name: String
    var email: String
    var credit_card: String
    var lastname: String
    var gender: Gender
    var bio: String
}
