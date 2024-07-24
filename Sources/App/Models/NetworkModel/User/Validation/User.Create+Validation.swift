//
//  User.Create+Validation.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Foundation

extension User.CreateDTO: UserValidatable {

    func validate() throws {
        try validate(password: password, confirmPassword: confirmPassword)

        try validate(phone: phone)

        if let email {
            try validate(email: email)
        }
    }

}
