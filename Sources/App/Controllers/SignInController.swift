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

        let user = User(
            user_id: 123,
            username: "geekbrains",
            name: "John",
            email: "some@some.ru",
            credit_card: "9872389-2424-234224-234",
            lastname: "Doe",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        let response = SignInResponse(
            result: 1,
            user: user)

        return req.eventLoop.future(response)
    }
}
