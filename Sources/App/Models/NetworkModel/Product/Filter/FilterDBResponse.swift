//
//  FilterDBResponse.swift
//
//
//  Created by Artem Mayer on 07.09.2024.
//

import Vapor

struct FilterDBResponse: Content {

    let propertyCode: String
    let propertyName: String
    let propertyValue: String
    var count: Int

    enum CodingKeys: String, CodingKey {
        case propertyCode = "property_code"
        case propertyName = "property_name"
        case propertyValue = "property_value"
        case count
    }

}
