//
//  AddProductController.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - AddProductController

class AddProductController {

    // MARK: - Functions

    func addProduct(_ req: Request) throws -> EventLoopFuture<AddProductResponse> {
        guard
            let model = try? req.content.decode(AddProductRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(model)
        
        let isAdded = MockBasket.shared.addProduct(to: model.user_id, by: model.product_id, of: model.quantity)

        guard isAdded else {
            let response = AddProductResponse(result: 0, error_message: "Товар отсутствует на складе!")
            return req.eventLoop.future(response)
        }

        let response = AddProductResponse(result: 1)
        return req.eventLoop.future(response)
    }
}
