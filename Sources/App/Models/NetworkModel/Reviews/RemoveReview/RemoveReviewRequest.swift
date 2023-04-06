//
//  RemoveReviewRequest.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - RemoveReviewRequest

struct RemoveReviewRequest: Content {
    var user_id: Int
    var review_id: Int
}
