//
//  SignUpController.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - SignUpController

class SignUpController {

    // MARK: - Properties

    let localStorage: LocalStorage

    // MARK: - Constructions

    required init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }

    // MARK: - Functions

    func signUp(_ req: Request) throws -> EventLoopFuture<SignUpResponse> {
        guard
            let requestUserData = try? req.content.decode(SignUpRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(requestUserData)

        let userErrorMessage = "Регистрация завершилась отказом! Введённый email и/или username уже существуют"
        var response: SignUpResponse

        if let successCreatedId = localStorage.create(user: requestUserData) {
            response = SignUpResponse(result: 1, user_id: successCreatedId, user_message: "Регистрация прошла успешно!")
        } else {
            response = SignUpResponse(result: 0, user_message: userErrorMessage)
        }

        return req.eventLoop.future(response)
    }
}
