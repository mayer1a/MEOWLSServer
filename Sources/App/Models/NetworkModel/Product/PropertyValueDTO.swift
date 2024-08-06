//
//  PropertyValueDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductVariantDTO {

    struct PropertyValueDTO: Content {

        let id: UUID
        let propertyID: UUID
        let value: String

        enum CodingKeys: String, CodingKey {
            case id
            case propertyID = "property_id"
            case value
        }

    }

}
