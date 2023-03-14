//
//  EditProfileController.swift
//
//
//  Created by Artem Mayer on 18.02.2023.
//

import Vapor

// MARK: - EditProfileController

class EditProfileController {

    // MARK: - Properties

    let localStorage: LocalStorage

    // MARK: - Constructions

    required init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }

    // MARK: - Functions

    func edit(_ req: Request) throws -> EventLoopFuture<EditProfileResponse> {
        guard
            let requestUserModel = try? req.content.decode(EditProfileRequest.self)
        else {
            throw Abort(.badRequest)
        }

        print(requestUserModel)

        let isUpdated = localStorage.update(user: requestUserModel)
        let errorMessage = "Не удалось обновить данные, так как Вы указываете неверный email, username или пароль"
        var response: EditProfileResponse

        if isUpdated {
            response = EditProfileResponse(result: 1)
        } else {
            response = EditProfileResponse(result: 0, error_message: errorMessage)
        }

        return req.eventLoop.future(response)
    }
}
