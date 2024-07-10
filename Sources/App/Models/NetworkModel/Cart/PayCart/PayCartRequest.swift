//
//  PayCartRequest.swift
//  
//
//  Created by Artem Mayer on 29.03.2023.
//

import Vapor

// MARK: - PayCartRequest

struct PayCartRequest: Content {
    var user_id: Int
}
