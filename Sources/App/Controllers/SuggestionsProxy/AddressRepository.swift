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

    func add(address: AddressDTO, to saveType: AddressDTO.SaveType) async throws {

        
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
