//
//  SignUpRequest.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - SignUpRequest

struct SignUpRequest: Content {
    var surname: String?
    var name: String?
    var patronymic: String?
    var birthday: Date?
    var gender: Gender
    var email: String
    var phone: String?
    var password: String
    var confirm_password: String?
    var credit_card: String?
}
