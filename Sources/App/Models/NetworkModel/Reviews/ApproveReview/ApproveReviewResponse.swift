//
//  ApproveReviewResponse.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - ApproveReviewResponse

struct ApproveReviewResponse: Content {
    var result: Int
    var error_message: String?
}
