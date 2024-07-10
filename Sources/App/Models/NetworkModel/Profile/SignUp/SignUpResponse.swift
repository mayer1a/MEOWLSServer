//
//  SignUpResponse.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - SignUpResponse

struct SignUpResponse: Content {
    var result: Int
    var user_id: UUID?
    var user_message: String
}
