//
//  MainBannerDTO+RedirectDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension MainBannerDTO {

    struct RedirectDTO: Content {

        let redirectType: RedirectType
        let objectID: UUID?
        let objectType: ObjectType?
        let productsSet: ProductsSetDTO?
        let url: String?

        enum CodingKeys: String, CodingKey {
            case redirectType = "type"
            case objectID = "object_id"
            case objectType = "object_type"
            case productsSet = "products_set"
            case url
        }

        init(redirectType: RedirectType,
             objectID: UUID? = nil,
             objectType: ObjectType? = nil,
             productsSet: ProductsSetDTO? = nil,
             url: String? = nil) {

            self.redirectType = redirectType
            self.objectID = objectID
            self.objectType = objectType
            self.productsSet = productsSet
            self.url = url
        }

    }

}
