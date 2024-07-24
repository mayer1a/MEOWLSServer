//
//  MainBannerDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct MainBannerDTO: Content {

    let id: UUID
    let title: String?
    let placeType: MainBanner.PlaceType?
    let redirect: RedirectDTO?
    let uiSettings: UISettingsDTO?
    let categories: [CategoryDTO]?
    let banners: [MainBannerDTO]?
    let products: [ProductDTO]?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, title
        case placeType = "place_type"
        case redirect
        case uiSettings = "ui_settings"
        case categories, banners, products, image
    }

}
