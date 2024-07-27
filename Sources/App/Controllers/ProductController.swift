//
//  ProductController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - ProductController

final class ProductController {

    func get(_ req: Request) throws -> EventLoopFuture<GetProductResponse> {
        guard let body = try? req.query.decode(GetProductRequest.self) else {
            throw Abort(.badRequest)
        }

        print(body)

        guard body.product_id > 0, let detailedProduct: Product? = nil else {
            let response = GetProductResponse(result: 0, error_message: "Товар не найден. Неверный id!")
            return req.eventLoop.future(response)
        }

        let response = GetProductResponse(result: 1, product: detailedProduct)

        return req.eventLoop.future(response)
    }
    
}
