//
//  SignInController.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - SignInController

final class SignInController {

    private let localStorage: LocalStorage

    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }

    func signIn(_ req: Request) throws -> EventLoopFuture<SignInResponse> {
        guard let requestUserData = try? req.content.decode(SignInRequest.self) else {
            throw Abort(.badRequest)
        }

        print(requestUserData)

        let userId = localStorage.getExistsUserId(email: requestUserData.email, password: requestUserData.password)
        var response: SignInResponse

        if let userId {
            let user = localStorage.read(by: userId)
            response = SignInResponse(result: 1, user: user)
        } else {
            response = SignInResponse(result: 0, error_message: "Неверный логин или пароль")
        }

        return req.eventLoop.future(response)
    }
    
}
