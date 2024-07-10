//
//  ValidationFailure.swift
//  
//
//  Created by Artem Mayer on 01.07.2024.
//

import Foundation

/// Structure for validation error failures.
struct ValidationFailure: Codable {
    /// Field with validation error.
    var field: String

    /// Validation message.
    var failure: String?
}
