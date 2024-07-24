//
//  MainBannerDTO+RedirectDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension MainBannerDTO {

    struct RedirectDTO: Content {

        let redirectType: MainBanner.Redirect.RedirectType
        let saleID: UUID?
        let productsSet: ProductsSetDTO?
        let url: String?

        enum CodingKeys: String, CodingKey {
            case redirectType = "type"
            case saleID = "sale_id"
            case productsSet = "products_set"
            case url
        }

    }

}
