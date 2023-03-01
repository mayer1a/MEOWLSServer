//
//  SignUpController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - SignUpController

class SignUpController {

    // MARK: - Functions

    func signUp(_ req: Request) throws -> EventLoopFuture<SignUpResponse> {
        guard
            let body = try? req.content.decode(SignUpRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = SignUpResponse(result: 1, user_message: "Регистрация прошла успешно!")
        
        return req.eventLoop.future(response)
    }
}
