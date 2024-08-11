//
//  User.Update+Validation.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Foundation

extension User.UpdateDTO: UserValidatable {

    func validate() throws {

        if password != nil || confirmPassword != nil {

            try validate(password: password, confirmPassword: confirmPassword)
        }
        
        try validate(phone: phone)

        if let email {
            try validate(email: email)
        }
    }

}
