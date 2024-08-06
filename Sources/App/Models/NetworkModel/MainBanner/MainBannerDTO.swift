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
    let placeType: PlaceType?
    let redirect: RedirectDTO?
    let uiSettings: UISettingsDTO?
    let categories: [CategoryDTO]?
    let banners: [MainBannerDTO]?
    var products: [ProductDTO]?
    let image: ImageDTO?

    enum CodingKeys: String, CodingKey {
        case id, title
        case placeType = "place_type"
        case redirect
        case uiSettings = "ui_settings"
        case categories, banners, products, image
    }

    init(id: UUID,
         title: String?,
         placeType: PlaceType? = nil,
         redirect: RedirectDTO?,
         uiSettings: UISettingsDTO? = nil,
         categories: [CategoryDTO]? = nil,
         banners: [MainBannerDTO]? = nil,
         products: [ProductDTO]? = nil,
         image: ImageDTO?) {

        self.id = id
        self.title = title
        self.placeType = placeType
        self.redirect = redirect
        self.uiSettings = uiSettings
        self.categories = categories
        self.banners = banners
        self.products = products
        self.image = image
    }

}
