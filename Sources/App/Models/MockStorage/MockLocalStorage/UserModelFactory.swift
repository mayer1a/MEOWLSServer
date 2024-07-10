//
//  UserModelFactory.swift
//
//
//  Created by Artem Mayer on 13.03.2023.
//

import Vapor

struct UserModelFactory {

    // MARK: - Functions

    func construct(from user: SignUpRequest, with id: UUID) -> User {
        User(id: .init(), surname: "", name: "", patronymic: "", birthday: nil, gender: nil, email: "", password: "", phone: nil, credit_card: "")
//        User(
//            user_id: id,
//            name: user.name,
//            lastname: user.lastname,
//            username: user.username,
//            email: user.email,
//            credit_card: user.credit_card,
//            gender: user.gender,
//            bio: user.bio)
    }

    func construct(from user: RawUpdateUserModel) -> User {
        User(id: .init(), surname: "", name: "", patronymic: "", birthday: nil, gender: nil, email: "", password: "", phone: nil, credit_card: "")
    }
}
