//
//  LogoutResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - LogoutResponse

struct LogoutResponse: Content {
    var result: Int
    var error_message: String?
}
