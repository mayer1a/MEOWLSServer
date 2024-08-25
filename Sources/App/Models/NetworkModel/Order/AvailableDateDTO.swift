//
//  AvailableDateDTO.swift
//
//
//  Created by Artem Mayer on 19.08.2024.
//

import Vapor

struct AvailableDateDTO: Content {

    let date: String
    let availableTimeIntervals: [DeliveryDTO.DeliveryTimeIntervalDTO]

}
