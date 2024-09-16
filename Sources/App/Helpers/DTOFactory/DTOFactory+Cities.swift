//
//  DTOFactory+Cities.swift
//  
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

extension DTOFactory {

    // MARK: - Cart

    static func makeCities(from cities: [City]) throws -> [CityDTO] {

        try cities.map { city in
            try makeCity(from: city)
        }
    }

    static func makeCity(from city: City) throws -> CityDTO {
        CityDTO(id: try city.requireID(), name: city.name, location: makeLocation(from: city.location))
    }

    static func makeLocation(from location: Location?) -> LocationDTO? {
        guard let location else { return nil }

        return LocationDTO(latitude: location.latitude, longitude: location.longitude)
    }

}
