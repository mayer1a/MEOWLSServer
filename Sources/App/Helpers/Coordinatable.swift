//
//  Coordinatable.swift
//
//
//  Created by Artem Mayer on 16.09.2024.
//

import Foundation

protocol Coordinatable {

    var latitude: Double { get }
    var longitude: Double { get }
    var coordinate: LocationDTO { get }

}

extension Coordinatable {

    var coordinate: LocationDTO {
        LocationDTO(latitude: latitude, longitude: longitude)
    }

}
