//
//  EditProfileController.swift
//  
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

class EditProfileController {

    // MARK: - Functions

    func edit(_ req: Request) throws -> EventLoopFuture<EditProfileResponse> {
        guard
            let body = try? req.content.decode(Profile.self)
        else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = EditProfileResponse(result: 1)

        return req.eventLoop.future(response)
    }
}
