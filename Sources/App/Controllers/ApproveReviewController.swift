//
//  ApproveReviewController.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - ApproveReviewController

class ApproveReviewController {

    // MARK: - Functions

    func approveReview(_ req: Request) throws -> EventLoopFuture<ApproveReviewResponse> {
        guard
            let body = try? req.content.decode(ApproveReviewRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = ApproveReviewResponse(result: 1)

        return req.eventLoop.future(response)
    }
}
