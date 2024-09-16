//
//  LocationDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct LocationDTO: Content, Coordinatable {

    let latitude: Double
    let longitude: Double

}
