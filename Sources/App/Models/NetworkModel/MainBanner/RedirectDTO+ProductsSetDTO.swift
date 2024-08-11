//
//  RedirectDTO+ProductsSetDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension RedirectDTO {

    struct ProductsSetDTO: Content {
        
        let name: String
        let category: CategoryDTO?
        let query: String?

        init(name: String, category: CategoryDTO? = nil, query: String? = nil) {
            self.name = name
            self.category = category
            self.query = query
        }

    }

}
