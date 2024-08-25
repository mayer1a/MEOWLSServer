//
//  SummaryDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct SummaryDTO: Content {

    let name: String
    let value: Double
    let type: SummaryType

    init(name: String = "Итого", value: Double = 0.0, type: SummaryType = .total) {
        self.name = name
        self.value = value
        self.type = type
    }

}
