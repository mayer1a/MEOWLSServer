//
//  FilterValueDTO.swift
//  
//
//  Created by Artem Mayer on 07.09.2024.
//

import Vapor

struct FilterValueDTO: Content {

    let value: String
    let displayName: String
    let count: Int?

    enum CodingKeys: String, CodingKey {
        case value
        case displayName = "display_name"
        case count
    }

    init(value: String, displayName: String, count: Int? = nil) {
        self.value = value
        self.displayName = displayName
        self.count = count
    }

}

extension FilterValueDTO {

    static var getSortValues: [FilterValueDTO] {
        [
            FilterValueDTO(value: "index", displayName: "По умолчанию"),
            FilterValueDTO(value: "price", displayName: "Сначала дешевые"),
            FilterValueDTO(value: "-price", displayName: "Сначала дорогие"),
            FilterValueDTO(value: "name", displayName: "По названию (А-я)"),
            FilterValueDTO(value: "-name", displayName: "По названию (Я-а)")
        ]
    }

}
