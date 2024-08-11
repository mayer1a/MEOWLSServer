//
//  Redirect+ObjectType.swift
//
//
//  Created by Artem Mayer on 05.08.2024.
//

import Vapor

extension Redirect {

    enum ObjectType: String, Content {

        case product = "Product"
        case sale = "Sale"

    }

}
