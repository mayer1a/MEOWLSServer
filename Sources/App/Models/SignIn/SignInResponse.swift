//
//  SignInResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - UserMainInfo

struct UserMainInfo: Content {
    var user_id: Int
    var username: String
    var name: String
    var lastname: String
}

// MARK: - SignInResponse

struct SignInResponse: Content {
    var result: Int
    var user: UserMainInfo?
    var error_message: String? = nil
}
