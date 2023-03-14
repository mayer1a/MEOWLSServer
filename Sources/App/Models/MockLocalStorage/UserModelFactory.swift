//
//  UserModelFactory.swift
//
//
//  Created by Artem Mayer on 13.03.2023.
//

import Foundation

struct UserModelFactory {

    // MARK: - Functions

    func construct(from user: SignUpRequest, with id: Int) -> User {
        User(
            user_id: id,
            name: user.name,
            lastname: user.lastname,
            username: user.username,
            email: user.email,
            credit_card: user.credit_card,
            gender: user.gender,
            bio: user.bio)
    }

    func construct(from user: RawUpdateUserModel) -> User {
        User(
            user_id: user.user_id,
            name: user.name,
            lastname: user.lastname,
            username: user.username,
            email: user.email,
            credit_card: user.credit_card,
            gender: user.gender,
            bio: user.bio)
    }
}
