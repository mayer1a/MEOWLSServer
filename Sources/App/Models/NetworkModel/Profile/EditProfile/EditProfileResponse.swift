//
//  EditProfileResponse.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - EditProfileResponse

struct EditProfileResponse: Content {
    var result: Int
    var error_message: String?
}
