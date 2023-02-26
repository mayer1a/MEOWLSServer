//
//  SignInController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - SignInController

class SignInController {

    // MARK: - Functions

    func signIn(_ req: Request) throws -> EventLoopFuture<SignInResponse> {
        guard
            let body = try? req.content.decode(SignInRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let user = UserMainInfo(
            user_id: 123,
            username: "geekbrains",
            name: "John",
            lastname: "Doe")

        let response = SignInResponse(
            result: 1,
            user: user)

        return req.eventLoop.future(response)
    }
}
