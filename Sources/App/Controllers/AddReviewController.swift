//
//  AddReviewController.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - AddReviewController

class AddReviewController {

    // MARK: - Functions

    func addReview(_ req: Request) throws -> EventLoopFuture<AddReviewResponse> {
        guard
            let body = try? req.content.decode(AddReviewRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = AddReviewResponse(
            result: 1,
            user_message: "Ваш отзыв был передан на модерацию")

        return req.eventLoop.future(response)
    }
}
