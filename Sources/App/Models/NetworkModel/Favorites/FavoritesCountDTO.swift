//
//  FavoritesCountDTO.swift
//  MEOWLSServer
//
//  Created by Artem Mayer on 04.10.2024.
//

import Vapor

struct FavoritesCountDTO: Content {

    let favoritesProductsCount: Int

    enum CodingKeys: String, CodingKey {
        case favoritesProductsCount = "favorites_products_count"
    }

}
