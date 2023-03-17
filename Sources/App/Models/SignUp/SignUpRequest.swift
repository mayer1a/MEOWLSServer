//
//  SignUpRequest.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - SignUpRequest

struct SignUpRequest: Content {
    var name: String
    var lastname: String
    var username: String
    var password: String
    var email: String
    var gender: Gender
    var credit_card: String
    var bio: String
}
