//
//  RemoveReviewController.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - RemoveReviewController

class RemoveReviewController {

    // MARK: - Functions

    func removeReview(_ req: Request) throws -> EventLoopFuture<RemoveReviewResponse> {
        guard
            let body = try? req.content.decode(RemoveReviewRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = RemoveReviewResponse(result: 1)

        return req.eventLoop.future(response)
    }
}
