//
//  CustomTokenAuthorization.swift
//
//
//  Created by Artem Mayer on 29.06.2024.
//

import Vapor

/// A custom token.
public struct CustomTokenAuthorization: Sendable {

    /// The plaintext token
    public let token: String

    /// Create a new `CustomTokenAuthorization`
    public init(token: String) {
        self.token = token
    }

}

extension HTTPHeaders {

    /// Access or set the `Authorization: Token ...` header.
    public var customTokenAuthorization: CustomTokenAuthorization? {
        get {
            guard let string = self.first(name: .authorization) else {
                return nil
            }

            let headerParts = string.split(separator: " ")
            guard headerParts.count == 2 else {
                return nil
            }
            guard headerParts[0].lowercased() == "token" else {
                return nil
            }
            return .init(token: String(headerParts[1]))
        }
        set {
            if let customToken = newValue {
                replaceOrAdd(name: .authorization, value: "Token \(customToken.token)")
            } else {
                remove(name: .authorization)
            }
        }
    }

}
