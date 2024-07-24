//
//  ReviewsController.swift
//
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

// MARK: - AddReviewController

final class ReviewsController {

    private let reviewsStorage: MockProductsReviews

    init(reviewsStorage: MockProductsReviews) {
        self.reviewsStorage = reviewsStorage
    }

    func addReview(_ req: Request) throws -> EventLoopFuture<AddReviewResponse> {
        guard let model = try? req.content.decode(AddReviewRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        let isReviewExists = reviewsStorage.isReviewExists(model)
        let isProductExists = MockProducts.shared.products.contains(where: { $0.product_id == model.product_id })
        var isUserExists = true

        if let userId = model.user_id {
//            isUserExists = localStorage.read(by: userId) != nil
        }

        var response: AddReviewResponse

        if isProductExists, isUserExists, !isReviewExists {
            let reviewId = reviewsStorage.addReview(model)
            response = AddReviewResponse(result: 1,
                                         user_message: "Ваш отзыв c идентификатором \"\(reviewId)\" был передан на модерацию")
        } else if !isProductExists {
            response = AddReviewResponse(result: 0,
                                         user_message: "Товара с указанным id не существует!")
        } else if !isUserExists {
            response = AddReviewResponse(result: 0,
                                         user_message: "Пользователя с указанным id не существует!")
        } else {
            response = AddReviewResponse(result: 0,
                                         user_message: "Данный отзыв уже существует!")
        }

        return req.eventLoop.future(response)
    }

    func approveReview(_ req: Request) throws -> EventLoopFuture<ApproveReviewResponse> {
        guard let model = try? req.content.decode(ApproveReviewRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        let isReviewExists = reviewsStorage.isReviewExists(id: model.review_id)
        let isAdminUser = false//LocalStorage().userIsAdmin(userId: model.user_id)
        var response: ApproveReviewResponse

        if isReviewExists, isAdminUser {
            response = ApproveReviewResponse(result: 1)
        } else if !isReviewExists {
            response = ApproveReviewResponse(result: 0, error_message: "Отзыва с заданным id не существует!")
        } else {
            response = ApproveReviewResponse(result: 0, error_message: "У Вас нет прав на одобрение отзывов!")
        }

        return req.eventLoop.future(response)
    }

    func removeReview(_ req: Request) throws -> EventLoopFuture<RemoveReviewResponse> {
        guard let model = try? req.content.decode(RemoveReviewRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        let isReviewExists = reviewsStorage.isReviewExists(id: model.review_id)
        let isAdminUser = false//LocalStorage().userIsAdmin(userId: model.user_id)
        var response: RemoveReviewResponse

        if isReviewExists, isAdminUser {
            response = RemoveReviewResponse(result: 1)
        } else if !isReviewExists {
            response = RemoveReviewResponse(result: 0, error_message: "Отзыва с заданным id не существует!")
        } else {
            response = RemoveReviewResponse(result: 0, error_message: "У Вас нет прав на удаление отзывов!")
        }

        return req.eventLoop.future(response)
    }

    func get(_ req: Request) throws -> EventLoopFuture<GetReviewsResponse> {
        guard let model = try? req.query.decode(GetReviewsRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        if model.page_number < 0 {
            let response = GetReviewsResponse(result: 0, error_message: "Отзывы не найдены. Неверный номер страницы!")
            return req.eventLoop.future(response)
        }

        let elementsInCollection = 20
        let reviews = reviewsStorage.getReviews(productId: model.product_id)

        guard reviews.count > 0 else {
            let response = GetReviewsResponse(result: 0, error_message: "Запрашиваемый товар не найден!")
            return req.eventLoop.future(response)
        }

        let reviewsLastIndex = reviews.count - 1
        var range: ClosedRange<Int>

        if model.page_number == 1 {
            let startIndex = 0
            var endIndex = elementsInCollection - 1
            endIndex = reviewsLastIndex < endIndex ? reviewsLastIndex : endIndex
            range = startIndex...endIndex
        } else if model.page_number == 0 {
            let startIndex = 0
            var endIndex = 2
            endIndex = reviewsLastIndex < endIndex ? reviewsLastIndex : endIndex
            range = startIndex...endIndex
        } else {
            let startIndex = model.page_number * 20

            guard startIndex >= reviewsLastIndex else {
                throw Abort(.noContent)
            }

            var endIndex = startIndex + elementsInCollection - 1
            endIndex = reviewsLastIndex < endIndex ? reviewsLastIndex : endIndex
            range = startIndex...endIndex
        }

        let resultReviews = Array(reviews[range])
        let nextPage = range.last ?? .max < reviewsLastIndex ? model.page_number + 1 : nil

        let response = GetReviewsResponse(
            result: 1,
            reviews: resultReviews,
            next_page: nextPage)

        return req.eventLoop.future(response)
    }
    
}
