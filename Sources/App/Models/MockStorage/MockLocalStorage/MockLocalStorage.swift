//
//  MockLocalStorage.swift
//
//
//  Created by Artem Mayer on 12.03.2023.
//

import Vapor

final class LocalStorage {

    // MARK: - Constructions

    init() {
        let initialAdminUser = SignUpRequest(surname: nil, name: "Artem", patronymic: nil, birthday: nil, gender: .man, email: "m1a@gmail.com", phone: nil, password: "abcdef1", confirm_password: "abcdef1", credit_card: nil)
//        SignUpRequest(
//            name: "Admin",
//            lastname: "Admin",
//            username: "adminadmin",
//            password: "Password0000",
//            email: "adminadmin@adm.in",
//            gender: .indeterminate,
//            credit_card: "0000000000000000",
//            bio: "I'm an admin person")

        create(user: initialAdminUser)

        guard let userId = getExistsUserId(email: initialAdminUser.email, password: initialAdminUser.password) else {
            print("ERROR: Initial user isn't admin!")
            return
        }

        addAdmin(userId: userId)
    }

    // MARK: - Functions

    func getExistsUserId(email key: String, password value: String) -> UUID? {
        hashedStorage.getExistsUserId(key: key, value: value)
    }

    func userIsAdmin(userId: UUID) -> Bool {
        adminsStorage.isAdminExists(with: userId)
    }

    @discardableResult
    func create(user: SignUpRequest) -> UUID? {
        guard
            !users.contains(where: { $0 == user }),
            hashedStorage.getExistsUserId(key: user.email, value: user.password) == nil
        else {
            return nil
        }

        let id = next_id
        let newUser = modelFactory.construct(from: user, with: id)

        users.append(newUser)
        hashedStorage.create(key: user.email, value: user.password, relatedId: id)

        return id
    }

    func read(by userId: UUID) -> User? {
        users.first(where: { $0.id == userId })
    }

    @discardableResult
    func update(user: EditProfileRequest) -> Bool {
        guard let existsUser = users.enumerated().first(where: { $0.element == user }) else { return false }

        if let isSuccess = updatePassword(key: existsUser.element.email, of: user.old_password, with: user.new_password) {
            guard isSuccess else { return false }
        }

        guard let newEmail = user.email, let email = updateEmail(of: existsUser.element.email, with: newEmail) else { return false }

        let newRawUser = RawUpdateUserModel()
//        newRawUser.name = !user.name.isEmpty ? user.name : existsUser.element.name
//        newRawUser.lastname = !user.lastname.isEmpty ? user.lastname : existsUser.element.lastname
//        newRawUser.username = !user.username.isEmpty ? user.username : existsUser.element.username
//        newRawUser.bio = !user.bio.isEmpty ? user.bio : existsUser.element.bio
//        newRawUser.credit_card = !user.credit_card.isEmpty ? user.credit_card : existsUser.element.credit_card
//        newRawUser.gender = user.gender
//        newRawUser.email = email
//        newRawUser.user_id = existsUser.element.user_id

        users[existsUser.offset] = modelFactory.construct(from: newRawUser)

        return true
    }

    @discardableResult
    func delete(by email: String, password: String) -> Bool {
        guard
            let userId = hashedStorage.getExistsUserId(key: email, value: password),
            let userIndex = users.enumerated().first(where: { $0.element.id == userId })?.offset
        else {
            return false
        }

        users.remove(at: userIndex)
        hashedStorage.delete(key: email, value: password)
        adminsStorage.deleteAdmin(removerId: userId, removeId: userId)

        return true
    }

    func deleteAll(removerEmail: String, removerPassword: String) {
        guard
            let userId = hashedStorage.getExistsUserId(key: removerEmail, value: removerPassword),
            users.contains(where: { $0.id == userId }),
            adminsStorage.isAdminExists(with: userId)
        else {
            return
        }

        hashedStorage.deleteAll()
        users.removeAll { user in
            guard user.id != userId else { return false }
            if let id = user.id {
                adminsStorage.deleteAdmin(removerId: userId, removeId: id)
            }
            return true
        }
        hashedStorage.create(key: removerEmail, value: removerPassword, relatedId: userId)
    }

    @discardableResult
    func addAdmin(userId: UUID) -> Bool {
        adminsStorage.addAdmin(with: userId)
    }

    @discardableResult
    func deleteAdmin(removerId: UUID, removeId: UUID) -> Bool {
        adminsStorage.deleteAdmin(removerId: removerId, removeId: removeId)
    }

    // MARK: - Private properties

    private let hashedStorage = HashedStorage()
    private let modelFactory = UserModelFactory()
    private let adminsStorage = AdminsStorage()
    private var last_used_id: UUID = .init()
    private var users: [User] = []

    private var next_id: UUID {
        last_used_id
    }

    // MARK: - Private functions

    @discardableResult
    private func updatePassword(key: String, of oldPassword: String?, with newPassword: String?) -> Bool? {
        if let oldPassword, let newPassword {
            guard !oldPassword.isEmpty, !newPassword.isEmpty else { return false }

            let isSuccess = hashedStorage.updatePassword(key: key, of: oldPassword, with: newPassword)
            return isSuccess
        } else {
            return nil
        }
    }

    @discardableResult
    private func updateEmail(of oldEmail: String?, with newEmail: String) -> String? {
        if !newEmail.isEmpty, oldEmail != newEmail {
            let isSuccess = hashedStorage.updateEmail(key: oldEmail ?? "", with: newEmail)

            guard isSuccess else { return nil }

            return newEmail
        } else {
            return oldEmail
        }
    }
}

fileprivate typealias ID = UUID

private final class HashedStorage {

    // MARK: - Typealiases

    typealias Email = String
    typealias PasswordHash = String

    // MARK: - Functions

    func create(key: String, value: String, relatedId: UUID) {
        hashedValues.updateValue(value, forKey: key)
        emailIdPairs.updateValue(relatedId, forKey: key)
    }

    func getExistsUserId(key: String, value: String) -> UUID? {
        guard hashedValues[key] == value else { return nil }
        return emailIdPairs[key]
    }

    @discardableResult
    func updatePassword(key: String, of oldValue: String, with newValue: String) -> Bool {
        guard getExistsUserId(key: key, value: oldValue) != nil else { return false }

        hashedValues.updateValue(newValue, forKey: key)
        return true
    }

    @discardableResult
    func updateEmail(key: String, with newValue: String) -> Bool {
        guard let relatedId = emailIdPairs[key], let relatedHashedValue = hashedValues[key] else { return false }

        hashedValues[newValue] = relatedHashedValue
        emailIdPairs[newValue] = relatedId

        hashedValues.removeValue(forKey: key)
        emailIdPairs.removeValue(forKey: key)

        return true
    }

    @discardableResult
    func delete(key: String, value: String) -> Bool {
        guard getExistsUserId(key: key, value: value) != nil else { return false }

        hashedValues.removeValue(forKey: key)
        emailIdPairs.removeValue(forKey: key)
        return true
    }

    func deleteAll() {
        hashedValues.removeAll()
        emailIdPairs.removeAll()
    }

    // MARK: - Private properties

    private var hashedValues: [Email: PasswordHash] = [:]
    private var emailIdPairs: [Email: ID] = [:]

}

private final class AdminsStorage {

    // MARK: - Constructions

    init() {
        self.admins = []
    }

    // MARK: - Functions

    @discardableResult
    func isAdminExists(with id: ID) -> Bool {
        admins.contains(id)
    }

    @discardableResult
    func addAdmin(with id: ID) -> Bool {
        guard !admins.contains(id) else { return false }
        admins.append(id)
        return true
    }

    @discardableResult
    func deleteAdmin(removerId: ID, removeId: ID) -> Bool {
        guard let index = admins.firstIndex(of: removeId), isAdminExists(with: removerId) else { return false }
        admins.remove(at: index)
        return true
    }

    // MARK: - Private properties

    private var admins: [ID]
}
