//
//  AvailabilityType.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor

extension AvailabilityInfo {

    enum AvailabilityType: String, Content {
        
        case available = "available"
        case delivery = "delivery"
        case notAvailable = "not_available"

        enum CodingKeys: String, CodingKey {
            case available
            case delivery
            case notAvailable = "not_available"
        }
        
    }

}
