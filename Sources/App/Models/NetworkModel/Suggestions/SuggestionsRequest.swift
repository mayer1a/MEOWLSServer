//
//  SuggestionsRequest.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

struct SuggestionsRequest: Content {

    let query: String
    let cityID: String?
    let streetID: String?

    enum CodingKeys: String, CodingKey {
        case query
        case cityID = "city_id"
        case streetID = "street_id"
    }

}
