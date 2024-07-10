//
//  AddReviewRequest.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - AddReviewRequest

struct AddReviewRequest: Content {
    var user_id: Int?
    var product_id: Int
    var rating: Int
    var date: TimeInterval
    var body: String
}
