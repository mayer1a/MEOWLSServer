//
//  CartDTO.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor


extension CartRequest {

    struct CartDTO: Content {

        let items: [Item]

    }

}

extension CartDTO {

    struct Item: Content {

        let count: Int
        let article: String

    }

}
