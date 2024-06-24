//
//  LogoutRequest.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - LogoutRequest

struct LogoutRequest: Content {
    var user_id: UUID
}
