//
//  EditProfileRequest.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - EditProfileRequest

struct EditProfileRequest: Content {
    var user_id: Int
    var username: String
    var password: String
    var email: String
    var gender: Gender
    var credit_card: String
    var bio: String
}
