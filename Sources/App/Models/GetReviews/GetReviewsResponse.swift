//
//  GetReviewsResponse.swift
//  
//
//  Created by Artem Mayer on 25.02.2023.
//

import Vapor

// MARK: - GetReviewsResponse

struct GetReviewsResponse: Content {
    var result: Int
    var reviews: [Review]?
    var error_message: String?
}
