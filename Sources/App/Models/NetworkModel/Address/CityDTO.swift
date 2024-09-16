//
//  CityDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

extension AddressDTO {

    struct CityDTO: Content {

        let id: UUID
        let name: String
        let location: LocationDTO?

    }

}
