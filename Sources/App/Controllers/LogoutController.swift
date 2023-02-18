//
//  LogoutController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

class LogoutController {

    // MARK: - Functions

    func logout(_ req: Request) throws -> EventLoopFuture<LogoutResponse> {
        guard
            let body = try? req.content.decode(LogoutRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = LogoutResponse(result: 1)

        return req.eventLoop.future(response)
    }
}
