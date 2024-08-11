//
//  LocationDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

extension AddressDTO {

    struct LocationDTO: Content {

        let latitude: Double
        let longitude: Double

    }

}
