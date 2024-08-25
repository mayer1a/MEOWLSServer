//
//  Sequence+ValidationFailureType.swift
//  
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation

extension Sequence where Element == ValidationFailureType {

    var toFailures: [ValidationFailure]? {
        self.compactMap { failureType -> ValidationFailure? in

            switch failureType {
            case .ID(let uuid):
                return .init(field: "ID", failure: uuid?.uuidString)

            case .addressType(let addressType):
                let type = addressType == .order ? "delivery" : "user"
                return .init(field: "Type", failure: type)

            case .environments:
                return .init(field: "ENVIRONMENTS DOES NOT FOUND")

            case .unavailableProduct(let name, let quantity):
                guard let name else { return nil }

                let failureMessage = "\"\(name)\" is available in quantity \(quantity) items"
                return .init(field: "\(name)", failure: failureMessage)

            case .databaseConnection:
                return .init(field: "Internal database connection lost")

            case .thirdPartyServiceUnavailable:
                return .init(field: "Third party service is temporarily unavailable. Please try again later")

            case .phoneNumber:
                return .init(field: "Phone number", failure: "Field is empty")

            case .email:
                return .init(field: "Email", failure: "Invalid format")

            case .password:
                let msg = "Make sure the password has at least one uppercase letter, one lowercase letter, "
                + "one digit, and a password length of at least 8."
                return .init(field: "Password", failure: msg)

            case .confirmPassword:
                return .init(field: "Confirm password",
                             failure: "The «Password» and «Repeat Password» fields must match.")

            }

        }
    }

}
