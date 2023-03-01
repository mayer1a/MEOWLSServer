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
            let body = try? req.content.decode(AddProductRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = AddProductResponse(result: 1)

        return req.eventLoop.future(response)
    }
}
