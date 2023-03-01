//
//  GetCatalogController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetCatalogController

class GetCatalogController {

    // MARK: - Functions

    func get(_ req: Request) throws -> EventLoopFuture<GetCatalogResponse> {
        guard
            let body = try? req.query.decode(GetCatalogRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let products = [
            Product(
                product_id: 123,
                product_name: "Ноутбук",
                product_price: 45600),
            Product(
                product_id: 456,
                product_name: "Компьютерная мышь",
                product_price: 1000)
        ]

        let response = GetCatalogResponse(
            result: 1,
            page_number: 1,
            products: products)

        return req.eventLoop.future(response)
    }
}
