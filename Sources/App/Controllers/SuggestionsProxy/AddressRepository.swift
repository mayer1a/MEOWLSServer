//
//  AddressRepository.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor
import Fluent
import CoreLocation

protocol AddressRepositoryProtocol: Sendable {

    func getCities(for location: LocationDTO?) async throws -> [CityDTO]
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

    func getCities(for location: LocationDTO?) async throws -> [CityDTO] {
        if let cities = try await getFromCache() {
            return sortCities(cities, by: location)
        }

        let cities = try await City.query(on: database)
            .with(\.$location)
            .all()
        let citiesDTO = try DTOFactory.makeCities(from: cities)
        try await setCache(citiesDTO)

        return sortCities(citiesDTO, by: location)
    }

    func addAddress(_ address: AddressDTO, for parent: UUID, to saveType: AddressDTO.SaveType) async throws {

        var deliveryID: UUID?
        var userID: UUID?

        switch saveType {
        case .order: deliveryID = parent
        case .user: userID = parent
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

        if let latitude = address.location?.latitude, let longitude = address.location?.longitude {
            try await Location(addressID: dbAddress.requireID(), latitude: latitude, longitude: longitude)
                .save(on: database)
        }
    }

    func getAddress(for user: User) async throws -> AddressDTO {

        let address = try await eagerLoadAddress(deliveryID: nil, userID: user.requireID())
        return try DTOFactory.makeAddress(from: address, for: .user)
    }

    func getAddress(for delivery: Delivery) async throws -> AddressDTO {

        let address = try await eagerLoadAddress(deliveryID: delivery.requireID(), userID: nil)
        return try DTOFactory.makeAddress(from: address, for: .order)
    }

    private func eagerLoadAddress(deliveryID: UUID?, userID: UUID?) async throws -> Address? {
        var addressQuery = Address.query(on: database)

        if let deliveryID {
            addressQuery = addressQuery
                .filter(\.$delivery.$id == deliveryID)
        } else if let userID {
            addressQuery = addressQuery
                .filter(\.$user.$id == userID)
        } else {
            return nil
        }

        return try await addressQuery
            .with(\.$city)
            .with(\.$location)
            .first()
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

    private func sortCities(_ cities: [CityDTO], by location: LocationDTO?) -> [CityDTO] {
        guard let location = location?.location else {
            return cities
        }
        
        return nearest(of: cities, to: location)
    }

    func nearest(of cities: [CityDTO], to location: CLLocation) -> [CityDTO] {
        cities.sorted {
            guard
                let leftCoordinate = $0.location?.coordinate,
                let rightCoordinate = $1.location?.coordinate
            else {
                return false
            }

            let leftLocation = CLLocation(latitude: leftCoordinate.latitude, longitude: leftCoordinate.longitude)
            let rightLocation = CLLocation(latitude: rightCoordinate.latitude, longitude: rightCoordinate.longitude)
            
            return leftLocation.distance(from: location) < rightLocation.distance(from: location)
        }
    }

}
