//
//  FavoritesDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct FavoritesDTO: Content {

    let id: UUID
    let products: [ProductDTO]

}
