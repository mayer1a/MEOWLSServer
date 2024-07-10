//
//  Gender.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor
import Fluent

// MARK: - Gender

enum Gender: String, Content {
    case man
    case woman
    case indeterminate
}
