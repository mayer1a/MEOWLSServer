//
//  UserPublicBuilder.swift
//
//
//  Created by Artem Mayer on 24.08.2024.
//

import Foundation

final class UserPublicBuilder {

    private var id: UUID?
    private var surname: String?
    private var name: String?
    private var patronymic: String?
    private var birthday: Date?
    private var gender: User.Gender?
    private var email: String?
    private var phone: String?
    private var authentication: Authentication?

    func setId(_ id: UUID?) -> UserPublicBuilder {
        self.id = id
        return self
    }

    func setSurname(_ surname: String?) -> UserPublicBuilder {
        self.surname = surname
        return self
    }

    func setName(_ name: String?) -> UserPublicBuilder {
        self.name = name
        return self
    }

    func setPatronymic(_ patronymic: String?) -> UserPublicBuilder {
        self.patronymic = patronymic
        return self
    }

    func setBirthday(_ birthday: Date?) -> UserPublicBuilder {
        self.birthday = birthday
        return self
    }

    func setGender(_ gender: User.Gender?) -> UserPublicBuilder {
        self.gender = gender
        return self
    }

    func setEmail(_ email: String?) -> UserPublicBuilder {
        self.email = email
        return self
    }

    func setPhone(_ phone: String) -> UserPublicBuilder {
        self.phone = phone
        return self
    }

    func setAuthentication(_ authentication: Authentication?) -> UserPublicBuilder {
        self.authentication = authentication
        return self
    }

    func build() throws -> User.PublicDTO {
        guard let phone else { throw ErrorFactory.badRequest(.phoneRequired) }

        return User.PublicDTO(id: id,
                              surname: surname,
                              name: name,
                              patronymic: patronymic,
                              birthday: birthday,
                              gender: gender,
                              email: email,
                              phone: phone,
                              authentication: authentication)
    }

}
