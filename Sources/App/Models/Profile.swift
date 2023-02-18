//
//  Profile.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - Gender

enum Gender: String, Content {
    case m
    case w
}

// MARK: - Profile

struct Profile: Content {
    var user_id: Int
    var username: String
    var password: String
    var email: String
    var gender: Gender
    var credit_card: String
    var bio: String
}
