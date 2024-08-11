//
//  DaDataRequest.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

struct DaDataRequest: Content {

    let query: String
    let fromBound: Bound?
    let toBound: Bound?
    let locations: [Location]?
    let restrictValue: Bool?
    let parts: [Part]?
    let count: Int = 20

    enum CodingKeys: String, CodingKey {
        case query
        case fromBound = "from_bound"
        case toBound = "to_bound"
        case locations
        case restrictValue = "restrict_value"
        case parts, count
    }

    init(query: String,
         from fromBound: Bound? = nil,
         to toBound: Bound? = nil,
         locations: [Location]? = nil,
         restrictValue: Bool? = true,
         parts: [Part]? = nil) {

        self.query = query
        self.fromBound = fromBound
        self.toBound = toBound
        self.locations = locations
        self.restrictValue = restrictValue
        self.parts = parts
    }

}

extension DaDataRequest {

    struct Bound: Content {

        let value: BoundType

    }

}

extension DaDataRequest {

    enum Part: String, Content {
        case surname = "SURNAME"
        case name = "NAME"
        case patronymic = "PATRONYMIC"
    }

}

extension DaDataRequest {

    struct Location: Content {

        let cityFiasID: String?
        let streetFiasID: String?

        enum CodingKeys: String, CodingKey {
            case cityFiasID = "city_fias_id"
            case streetFiasID = "street_fias_id"
        }

        init(cityFiasID: String? = nil, streetFiasID: String? = nil) {
            self.cityFiasID = cityFiasID
            self.streetFiasID = streetFiasID
        }

    }

}

extension DaDataRequest.Bound {

    enum BoundType: String, Content {
        case street
        case house
        case flat
    }

}
