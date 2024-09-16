//
//  DistanceHelper.swift
//
//
//  Created by Artem Mayer on 16.09.2024.
//

import Foundation

struct DistanceHelper {

    private init() {}

    static func distanceBetween(_ leftLocation: LocationDTO, _ rightLocation: LocationDTO) -> Double {
        let earthRadius = 6371.0

        let lat1 = leftLocation.latitude * .pi / 180
        let lon1 = leftLocation.longitude * .pi / 180
        let lat2 = rightLocation.latitude * .pi / 180
        let lon2 = rightLocation.longitude * .pi / 180

        let dlat = lat2 - lat1
        let dlon = lon2 - lon1

        let a = sin(dlat / 2) * sin(dlat / 2) + cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        return earthRadius * c
    }

}
