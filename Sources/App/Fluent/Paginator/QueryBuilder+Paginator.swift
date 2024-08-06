//
//  QueryBuilder+Paginator.swift
//
//
//  Created by Artem Mayer on 29.07.2024.
//

import Fluent

extension QueryBuilder {

    func paginate(with request: PageRequest) async throws -> PaginationResponse<Model> {
        try await self.paginate(with: request.page, size: request.perPage)
    }

    func paginate(with index: Int, size perPage: Int) async throws -> PaginationResponse<Model> {
        try await self.page(withIndex: index, size: perPage).get()
    }

    /// Returns a single `PaginationResponse` page out of the complete result set.
    ///
    /// This method will first `count()` the result set, then request a subset of the results using `range()` and `all()`.
    ///
    /// - Parameters:
    ///   - page: The index of the page.
    ///   - perPage: The size of the page.
    /// - Returns: A single `PaginationResponse` page of the result set containing the requested items and page metadata `PaginationInfo`.
    func page(withIndex page: Int, size perPage: Int) -> EventLoopFuture<PaginationResponse<Model>> {

        let trimmedRequest: Fluent.PageRequest = {
            
            guard let pageSizeLimit = database.context.pageSizeLimit else {
                return .init(page: Swift.max(page, 1), per: Swift.max(perPage, 1))
            }
            return .init(page: Swift.max(page, 1), per: Swift.max(Swift.min(perPage, pageSizeLimit), 1))
        }()

        let count = count()
        let items = copy().range(trimmedRequest.start..<trimmedRequest.end).all()

        return items.and(count).map { models, total in

            let prevPage = page > 1 ? page - 1 : 0
            let sendedItems = perPage * prevPage
            let nextPage: Int? = (total - sendedItems - trimmedRequest.per) > 0 ? page + 1 : nil

            let paginationInfo = PaginationInfo(page: trimmedRequest.page,
                                                nextPage: nextPage,
                                                perPage: trimmedRequest.per,
                                                totalCount: total)
            return PaginationResponse(results: models, paginationInfo: paginationInfo)
        }
    }

}
