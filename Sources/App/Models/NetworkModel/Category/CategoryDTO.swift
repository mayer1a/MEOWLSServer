//
//  CategoryDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

final class CategoryDTO: Content {

    let id: UUID
    let code: String
    let name: String
    let parent: CategoryDTO?
    let products: [ProductDTO]?
    let hasChildren: Bool
    let image: ImageDTO?
    let productsCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, code, name, parent, products
        case hasChildren = "has_children"
        case image
        case productsCount = "products_count"
    }

    init(id: UUID,
         code: String,
         name: String,
         parent: CategoryDTO? = nil,
         products: [ProductDTO]? = nil,
         hasChildren: Bool,
         image: ImageDTO? = nil,
         productsCount: Int? = nil) {

        self.id = id
        self.code = code
        self.name = name
        self.parent = parent
        self.products = products
        self.hasChildren = hasChildren
        self.image = image
        self.productsCount = productsCount
    }

}
