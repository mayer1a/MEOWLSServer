//
//  Gender.swift
//
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

extension User {

    enum Gender: String, Content {

        case man
        case woman
        case indeterminate

    }

}
