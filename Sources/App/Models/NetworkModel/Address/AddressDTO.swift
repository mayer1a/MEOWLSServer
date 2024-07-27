//
//  AddressDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct AddressDTO: Content {

    let street: String
    let house: String
    let entrance: String?
    let floor: String?
    let flat: String?
    let formatted: String
    let city: CityDTO
    let location: LocationDTO?

}
