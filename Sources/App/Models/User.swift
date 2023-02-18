//
//  User.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

struct User: Content {
    var id_user: Int
    var user_login: String
    var user_name: String
    var user_lastname: String
}
