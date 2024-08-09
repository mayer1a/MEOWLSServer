//
//  AddressDTO.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct AddressDTO: Content {

    let city: CityDTO
    let street: String
    let house: String
    let flat: String?
    let entrance: String?
    let floor: String?
    let formatted: String?
    let location: LocationDTO?

    func format() -> String {

        let granularAddress: [String?] = [street, house, flat]

        return "\(city.name), \(granularAddress.compactMap({$0}).joined(separator: ", "))"
    }

}
