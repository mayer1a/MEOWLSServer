//
//  User.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - User

struct User: Content, Equatable {

    // MARK: - Properties
    
    var user_id: Int
    var name: String
    var lastname: String
    var username: String
    var email: String
    var credit_card: String
    var gender: Gender
    var bio: String

    // MARK: - Functions

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.user_id == rhs.user_id
    }

    static func == (lhs: User, rhs: EditProfileRequest) -> Bool {
        lhs.user_id == rhs.user_id
    }

    static func == (lhs: User, rhs: SignUpRequest) -> Bool {
        lhs.username == rhs.username || lhs.email == rhs.email
    }

}
