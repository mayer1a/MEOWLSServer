//
//  GetReviewsRequest.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetReviewsRequest

struct GetReviewsRequest: Content {
    var product_id: Int
}
