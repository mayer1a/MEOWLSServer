//
//  RegisterRequest.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

struct RegisterRequest: Content {
    var id_user: Int
    var username: String
    var password: String
    var email: String
    var gender: String
    var credit_card: String
    var bio: String
}
