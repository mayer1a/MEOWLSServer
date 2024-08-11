//
//  AddressDTO+SaveType.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

extension AddressDTO {

    enum SaveType: Content {
        case order
        case user
    }

}
