//
//  SignInRequest.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - SignInRequest

struct SignInRequest: Content {
    var email: String
    var password: String
}
