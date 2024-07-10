//
//  EditProfileRequest.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - EditProfileRequest

struct EditProfileRequest: Content {
    
    var id: UUID
    var surname: String?
    var name: String?
    var patronymic: String?
    var birthday: Date?
    var gender: Gender?
    var old_password: String?
    var new_password: String?
    var email: String?
    var credit_card: String?
    
}
