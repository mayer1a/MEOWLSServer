//
//  GetReviewsController.swift
//  
//
//  Created by Artem Mayer on 25.02.2023.
//

import Vapor

class GetReviewsController {

    // MARK: - Functions

    func get(_ req: Request) throws -> EventLoopFuture<GetReviewsResponse> {
        guard
            let body = try? req.content.decode(GetReviewsRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let reviews = [
            Review(
                review_id: 111,
                product_id: 456,
                user_id: 123,
                description: "Хорошая мышь"),
            Review(
                review_id: 112,
                product_id: 123,
                description: "Стоит своих денег!")
        ]

        let response = GetReviewsResponse(
            result: 1,
            reviews: reviews)

        return req.eventLoop.future(response)
    }
}
