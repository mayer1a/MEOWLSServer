//
//  SignUpRequest.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - SignUpResponse

struct SignUpRequest: Content {
    var username: String
    var password: String
    var email: String
    var gender: Gender
    var credit_card: String
    var bio: String
}
