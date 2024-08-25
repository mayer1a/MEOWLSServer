//
//  MainBannerDTOBuilder.swift
//
//
//  Created by Artem Mayer on 24.08.2024.
//

import Foundation

final class MainBannerDTOBuilder {

    private var id: UUID?
    private var title: String?
    private var placeType: PlaceType?
    private var redirect: RedirectDTO?
    private var uiSettings: UISettingsDTO?
    private var categories: [CategoryDTO]?
    private var banners: [MainBannerDTO]?
    private var products: [ProductDTO]?
    private var image: ImageDTO?

    func setId(_ id: UUID) -> MainBannerDTOBuilder {
        self.id = id
        return self
    }

    func setTitle(_ title: String?) -> MainBannerDTOBuilder {
        self.title = title
        return self
    }

    func setPlaceType(_ placeType: PlaceType?) -> MainBannerDTOBuilder {
        self.placeType = placeType
        return self
    }

    func setRedirect(_ redirect: RedirectDTO?) -> MainBannerDTOBuilder {
        self.redirect = redirect
        return self
    }

    func setUISettings(_ uiSettings: UISettingsDTO?) -> MainBannerDTOBuilder {
        self.uiSettings = uiSettings
        return self
    }

    func setCategories(_ categories: [CategoryDTO]?) -> MainBannerDTOBuilder {
        self.categories = categories
        return self
    }

    func setBanners(_ banners: [MainBannerDTO]?) -> MainBannerDTOBuilder {
        self.banners = banners
        return self
    }

    func setProducts(_ products: [ProductDTO]?) -> MainBannerDTOBuilder {
        self.products = products
        return self
    }

    func setImage(_ image: ImageDTO?) -> MainBannerDTOBuilder {
        self.image = image
        return self
    }

    func build() throws -> MainBannerDTO {
        guard let id else { throw ErrorFactory.internalError(.bannerIDRequired) }

        return MainBannerDTO(id: id,
                             title: title,
                             placeType: placeType,
                             redirect: redirect,
                             uiSettings: uiSettings,
                             categories: categories,
                             banners: banners,
                             products: products,
                             image: image)
    }

}
