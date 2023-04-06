//
//  LogoutController.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - LogoutController

class LogoutController {

    // MARK: - Properties

    let localStorage: LocalStorage

    // MARK: - Constructions

    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }

    // MARK: - Functions

    func logout(_ req: Request) throws -> EventLoopFuture<LogoutResponse> {
        guard
            let model = try? req.content.decode(LogoutRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(model)

        let isUserExists = localStorage.read(by: model.user_id) != nil
        var response: LogoutResponse

        if isUserExists {
            response = LogoutResponse(result: 1)
        } else {
            response = LogoutResponse(result: 0)
        }

        return req.eventLoop.future(response)
    }
}
