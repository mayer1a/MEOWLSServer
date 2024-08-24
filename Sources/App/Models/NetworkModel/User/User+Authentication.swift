//
//  User+Authentication.swift
//  
//
//  Created by Artem Mayer on 24.08.2024.
//

import Vapor

extension User {

    struct Authentication: Content {
        
        let token: String?
        let expiresAt: Date?

        enum CodingKeys: String, CodingKey {
            case token
            case expiresAt = "expires_at"
        }

    }

}
