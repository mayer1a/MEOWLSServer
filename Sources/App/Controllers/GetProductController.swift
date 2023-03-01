//
//  GetProductController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - GetProductController

class GetProductController {

    // MARK: - Functions

    func get(_ req: Request) throws -> EventLoopFuture<GetProductResponse> {
        guard
            let body = try? req.query.decode(GetProductRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let product = DetailedProduct(product_description: "[Подробное описание товара]")

        let response = GetProductResponse(result: 1, product: product)

        return req.eventLoop.future(response)
    }
}
