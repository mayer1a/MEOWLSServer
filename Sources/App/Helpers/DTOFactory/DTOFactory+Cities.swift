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
        CityDTO(id: try city.requireID(), name: city.name)
    }

}
