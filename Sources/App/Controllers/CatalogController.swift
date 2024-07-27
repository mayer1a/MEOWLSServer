//
//  CatalogController.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - CatalogController

final class CatalogController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let builder = routes.grouped("catalog")
        builder.get(use: getCatalog)
    }

    private func getCatalog(_ req: Request) throws -> EventLoopFuture<GetCatalogResponse> {
        guard let body = try? req.query.decode(GetCatalogRequest.self) else {
            throw Abort(.badRequest)
        }

        print(body)

        if body.page_number <= 0 {
            let response = GetCatalogResponse(result: 0, error_message: "Номер страницы должен быть больше 0!")
            return req.eventLoop.future(response)
        }

        let elementsInCollection = 20
        let productsLastIndex = 0
        var range: ClosedRange<Int>

        if body.page_number == 1 {
            let startIndex = 0
            var endIndex = elementsInCollection - 1
            endIndex = productsLastIndex < endIndex ? productsLastIndex : endIndex
            range = startIndex...endIndex
        } else {
            let startIndex = body.page_number * 20

            guard startIndex >= productsLastIndex else {
                throw Abort(.noContent)
            }

            var endIndex = startIndex + elementsInCollection - 1
            endIndex = productsLastIndex < endIndex ? productsLastIndex : endIndex
            range = startIndex...endIndex
        }

//        let products = Array(MockProducts.shared.products[range])
        let nextPage = range.last ?? .max < productsLastIndex ? body.page_number + 1 : nil

        let response = GetCatalogResponse(
            result: 1,
            products: nil,
            next_page: nextPage)

        return req.eventLoop.future(response)
    }
    
}
