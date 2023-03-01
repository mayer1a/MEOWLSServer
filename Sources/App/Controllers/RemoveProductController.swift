//
//  RemoveProductController.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - RemoveProductController

class RemoveProductController {

    // MARK: - Functions

    func removeProduct(_ req: Request) throws -> EventLoopFuture<RemoveProductResponse> {
        guard
            let body = try? req.content.decode(RemoveProductRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = RemoveProductResponse(result: 1)

        return req.eventLoop.future(response)
    }
}
