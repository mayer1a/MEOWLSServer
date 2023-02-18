//
//  RegisterResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

struct RegisterResponse: Content {
    var result: Int
    var user_message: String?
    var error_message: String?
}
