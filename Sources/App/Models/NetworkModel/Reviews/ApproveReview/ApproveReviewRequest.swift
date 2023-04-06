//
//  ApproveReviewRequest.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - ApproveReviewRequest

struct ApproveReviewRequest: Content {
    var user_id: Int
    var review_id: Int
}
