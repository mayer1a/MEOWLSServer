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

    init(name: String = "Итого", value: Double = 0.0) {
        self.name = name
        self.value = value
    }

}
