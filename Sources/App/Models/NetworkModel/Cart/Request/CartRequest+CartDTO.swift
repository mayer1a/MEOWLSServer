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
        let save: Bool

        init(items: [Item], save: Bool = true) {
            self.items = items
            self.save = save
        }

    }

}

extension CartRequest.CartDTO {

    struct Item: Content {

        let article: String
        let count: Int

    }

}
