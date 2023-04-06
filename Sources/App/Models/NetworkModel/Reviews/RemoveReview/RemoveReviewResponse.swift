//
//  RemoveReviewResponse.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - RemoveReviewResponse

struct RemoveReviewResponse: Content {
    var result: Int
    var error_message: String?
}
