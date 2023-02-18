//
//  SignInResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

struct SignInResponse: Content {
    var result: Int
    var user: User?
    var error_message: String? = nil
}
