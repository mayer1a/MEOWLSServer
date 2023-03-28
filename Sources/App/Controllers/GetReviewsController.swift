//
//  GetReviewsController.swift
//  
//
//  Created by Artem Mayer on 25.02.2023.
//

import Vapor

// MARK: - GetReviewsController

class GetReviewsController {

    // MARK: - Functions

    func get(_ req: Request) throws -> EventLoopFuture<GetReviewsResponse> {
        guard
            let body = try? req.query.decode(GetReviewsRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        if body.page_number < 0 {
            let response = GetReviewsResponse(result: 0, error_message: "Отзывы не найдены. Неверный номер страницы!")
            return req.eventLoop.future(response)
        }

        let elementsInCollection = 20
        let relatedReviews = MockProductsReviews.shared.reviews.compactMap { review -> Review? in
            guard review.product_id == body.product_id else { return nil }
            return review
        }

        let reviewsLastIndex = relatedReviews.count - 1
        var range: ClosedRange<Int>

        if body.page_number == 1 {
            let startIndex = 0
            var endIndex = elementsInCollection - 1
            endIndex = reviewsLastIndex < endIndex ? reviewsLastIndex : endIndex
            range = startIndex...endIndex
        } else if body.page_number == 0 {
            let startIndex = 0
            var endIndex = 2
            endIndex = reviewsLastIndex < endIndex ? reviewsLastIndex : endIndex
            range = startIndex...endIndex
        } else {
            let startIndex = body.page_number * 20

            guard startIndex >= reviewsLastIndex else {
                throw Abort(.noContent)
            }

            var endIndex = startIndex + elementsInCollection - 1
            endIndex = reviewsLastIndex < endIndex ? reviewsLastIndex : endIndex
            range = startIndex...endIndex
        }

        let reviews = Array(relatedReviews[range])
        let nextPage = range.last ?? .max < reviewsLastIndex ? body.page_number + 1 : nil

        let response = GetReviewsResponse(
            result: 1,
            reviews: reviews,
            next_page: nextPage)

        return req.eventLoop.future(response)
    }
}
