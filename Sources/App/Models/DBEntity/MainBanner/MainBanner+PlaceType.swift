//
//  MainBanner+PlaceType.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor

extension MainBanner {

    enum PlaceType: String, Content {
        
        case categories
        case bannersHorizontal = "banners_horizontal"
        case productsCollection = "products_collection"
        case bannersVertical = "banners_vertical"
        case singleBanner = "single_banner"

    }

}
