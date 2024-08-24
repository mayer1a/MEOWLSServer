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

    /// Format token value for example`Token ib54K9o7UrcfSknuSXiG5l3oiJWSTm0L45D9aA8Cf+Y=`
    public var tokenFormatValue: String {
        "Token \(token)"
    }

}

extension HTTPHeaders {

    /// Access or set the `Authorization: Token ...` header.
    public var customTokenAuthorization: CustomTokenAuthorization? {

        get {

            guard let string = self.first(name: .authorization) else { return nil }

            let headerParts = string.split(separator: " ")

            guard headerParts.count == 2, headerParts[0].lowercased() == "token" else { return nil }

            return .init(token: String(headerParts[1]))
        }
        set {

            if let customToken = newValue {
                replaceOrAdd(name: .authorization, value: customToken.tokenFormatValue)
            } else {
                remove(name: .authorization)
            }
        }
    }

}
