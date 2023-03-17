//
//  Gender.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - Gender

enum Gender: String, Content {
    case man = "Мужской"
    case woman = "Женский"
    case indeterminate = "Другой"
}
