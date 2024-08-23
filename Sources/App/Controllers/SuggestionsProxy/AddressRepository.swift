//
//  AddressRepository.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor
import Fluent

protocol AddressRepositoryProtocol: Sendable {

    func getCities() async throws -> [CityDTO]
    func addAddress(_ address: AddressDTO, for parent: UUID, to saveType: AddressDTO.SaveType) async throws
    func getAddress(for user: User) async throws -> AddressDTO
    func getAddress(for delivery: Delivery) async throws -> AddressDTO

}

final class AddressRepository: AddressRepositoryProtocol {

    private let database: Database
    private let cache: Application.Caches

    init(database: Database, cache: Application.Caches) {
        self.database = database
        self.cache = cache
    }

    func getCities() async throws -> [CityDTO] {

        if let cities = try await getFromCache() {

            return cities
        }

        let cities = try await City.query(on: database).all()

        return try DTOBuilder.makeCities(from: cities)
    }

    func addAddress(_ address: AddressDTO, for parent: UUID, to saveType: AddressDTO.SaveType) async throws {

        var deliveryID: UUID?
        var userID: UUID?

        switch saveType {
        case .order:
            deliveryID = parent

        case .user:
            userID = parent

        }

        let dbAddress = Address(cityID: address.city.id,
                                deliveryID: deliveryID,
                                userID: userID,
                                street: address.street,
                                house: address.house,
                                entrance: address.entrance,
                                floor: address.floor,
                                flat: address.flat,
                                formattedString: address.format())

        try await dbAddress.save(on: database)
    }

    func getAddress(for user: User) async throws -> AddressDTO {

        let address = try await Address.query(on: database)
            .filter(\.$user.$id == user.requireID())
            .with(\.$city)
            .with(\.$location)
            .first()

        return try DTOBuilder.makeAddress(from: address, for: .user)
    }

    func getAddress(for delivery: Delivery) async throws -> AddressDTO {

        let address = try await Address.query(on: database)
            .filter(\.$delivery.$id == delivery.requireID())
            .with(\.$city)
            .with(\.$location)
            .first()

        return try DTOBuilder.makeAddress(from: address, for: .order)
    }

    private func setCache(_ response: [CityDTO]) async throws {

        do {
            try await cache.memory.set("cities", to: response, expiresIn: .seconds(Date().secondsUntilEndOfDay))
        } catch {
            try await cache.memory.delete("cities")
        }
    }

    private func getFromCache() async throws -> [CityDTO]? {

        try await cache.memory.get("cities", as: [CityDTO].self)
    }

}
