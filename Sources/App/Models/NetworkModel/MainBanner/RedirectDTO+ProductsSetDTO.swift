//
//  RedirectDTO+ProductsSetDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension MainBannerDTO.RedirectDTO {

    struct ProductsSetDTO: Content {
        
        let name: String
        let category: CategoryDTO?
        let query: String?

    }

}
