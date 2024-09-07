//
//  FilterDTO.swift
//  
//
//  Created by Artem Mayer on 07.09.2024.
//

import Vapor

struct FilterDTO: Content {

    let name: String
    let displayName: String
    let type: FilterType
    let values: [FilterValueDTO]
    let defaultValue: String?

    enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
        case type, values
        case defaultValue = "default_value"
    }

    init(name: String = "sort",
         displayName: String = "Сортировка",
         type: FilterType = .multiple,
         values: [FilterValueDTO],
         defaultValue: String? = nil) {

        self.name = name
        self.displayName = displayName
        self.type = type
        self.values = values
        self.defaultValue = defaultValue
    }

}

extension FilterDTO {

    static var getSortFilter: FilterDTO {
        FilterDTO(type: .single, values: FilterValueDTO.getSortValues, defaultValue: "index")
    }

}
