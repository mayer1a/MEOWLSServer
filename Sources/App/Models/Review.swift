//
//  Review.swift
//
//
//  Created by Artem Mayer on 25.02.2023.
//

import Vapor

// MARK: - Review

struct Review: Content {
    var review_id: Int
    var product_id: Int
    var user_id: Int?
    var description: String
}
