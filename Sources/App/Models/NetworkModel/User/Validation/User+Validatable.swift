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

    private var passwordConfirmError: String {
        "The \"Password\" and \"Repeat password\" fields must match"
    }
    private var passwordFormatError: String {
        "Make sure the password has at least one uppercase letter, one lowercase letter, "
        + "one digit, and a password length of at least 8."
    }

    func validate(password: String?, confirmPassword: String?) throws {

        guard let password, let confirmPassword, password == confirmPassword else {
            throw makeError(with: "Passwords did not match",
                            [.init(field: "Password"), .init(field: "Confirm password", failure: passwordConfirmError)])
        }

        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,20}$"
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(password.startIndex..., in: password)
        let firstMatch = regex.firstMatch(in: password, options: .reportProgress, range: range)

        guard firstMatch != nil else {
            throw makeError(with: "Invalid password format", [.init(field: "Password", failure: passwordFormatError)])
        }
    }

    func validate(email: String) throws {

        if email.isEmpty == false {

            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(email.startIndex..., in: email)
            let firstMatch = regex.firstMatch(in: email, options: .reportProgress, range: range)
            
            guard firstMatch != nil else {
                throw makeError(with: "Invalid email format", [.init(field: "Email", failure: "Invalid format")])
            }
        }
    }

    func validate(phone: String) throws {

        if phone.isEmpty == true {

            throw makeError(with: "Phone number required", [.init(field: "Phone number", failure: "Field is empty")])
        }
    }

    func makeError(with reason: String, _ failures: [ValidationFailure]) -> CustomErrorProtocol {
        
        CustomError(.badRequest, code: "validationError", reason: reason, failures: failures)
    }

}
