//
//  User+Validatable.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Foundation

protocol UserValidatable {

    /// Validate phone, email, passwords
    func validate() throws
    func validate(password: String?, confirmPassword: String?) throws
    func validate(email: String) throws
    func validate(phone: String) throws

}

extension UserValidatable {

    func validate(password: String?, confirmPassword: String?) throws {

        guard let password, let confirmPassword, password == confirmPassword else {
            throw ErrorFactory.badRequest(.passwordsDidNotMatch, failures: [.confirmPassword])
        }

        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,20}$"
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(password.startIndex..., in: password)
        let firstMatch = regex.firstMatch(in: password, options: .reportProgress, range: range)

        guard firstMatch != nil else { throw ErrorFactory.badRequest(.invalidPasswordFormat, failures: [.password]) }
    }

    func validate(email: String) throws {

        if email.isEmpty == false {

            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(email.startIndex..., in: email)
            let firstMatch = regex.firstMatch(in: email, options: .reportProgress, range: range)
            
            guard firstMatch != nil else { throw ErrorFactory.badRequest(.invalidEmailFormat, failures: [.email]) }
        }
    }

    func validate(phone: String) throws {
        if phone.isEmpty == true {
            throw ErrorFactory.badRequest(.phoneRequired, failures: [.phoneNumber])
        }
    }

}
