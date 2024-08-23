//
//  DTOBuilder+Banners.swift
//  
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOBuilder {

    // MARK: - Banners

    static func makeBanners(from banners: [MainBanner], fullModel: Bool = true) throws -> [MainBannerDTO] {

        try banners.map { mainBanner in

            var uiSettings: UISettingsDTO?
            var placeType: PlaceType?
            var categories: [CategoryDTO]?
            var childBanners: [MainBannerDTO]?
            var products: [ProductDTO]?

            if fullModel {
                uiSettings = makeUISettings(from: mainBanner.uiSettings)
                placeType = mainBanner.placeType

                let bannerCategories = try mainBanner.categories.map { category in

                    guard let categoryDTO = try makeCategory(from: category) else {
                        throw ErrorFactory.internalError(.bannerCategoriesError, failures: [.ID(category.id)])
                    }
                    return categoryDTO
                }

                categories = bannerCategories.isEmpty ? nil : bannerCategories
                products = try makeProducts(from: mainBanner.products)

                let child = try makeBanners(from: mainBanner.banners, fullModel: false)
                childBanners = child.isEmpty ? nil : child
            }

            return MainBannerDTO(id: try mainBanner.requireID(),
                                 title: mainBanner.title,
                                 placeType: placeType,
                                 redirect: try makeRedirect(from: mainBanner.redirect, fullModel: !fullModel),
                                 uiSettings: uiSettings,
                                 categories: categories,
                                 banners: childBanners,
                                 products: products,
                                 image: makeImage(from: mainBanner.image))
        }
    }

    // MARK: - UISettings

    static func makeUISettings(from uiSettings: UISettings?) -> UISettingsDTO? {

        guard let uiSettings else { return nil }

        return UISettingsDTO(backgroundColor: uiSettings.backgroundColor,
                             spasings: makeSpacing(from: uiSettings.spasings),
                             cornerRadiuses: makeCornerRadius(from: uiSettings.cornerRadiuses),
                             autoSlidingTimeout: uiSettings.autoSlidingTimeout,
                             metrics: makeMetric(from: uiSettings.metrics))
    }

    // MARK: - Spacings

    static func makeSpacing(from spacing: Spacing?) -> SpacingDTO? {

        guard let spacing else { return nil }

        return SpacingDTO(top: spacing.top, bottom: spacing.bottom)
    }

    // MARK: - CornerRadius

    static func makeCornerRadius(from cornerRadius: CornerRadius?) -> CornerRadiusDTO? {

        guard let cornerRadius else { return nil }

        return CornerRadiusDTO(topLeft: cornerRadius.topLeft,
                               topRight: cornerRadius.topRight,
                               bottomLeft: cornerRadius.bottomLeft,
                               bottomRight: cornerRadius.bottomRight)
    }

    // MARK: - Metric

    static func makeMetric(from metric: [Metric]?) -> [MetricDTO]? {

        guard metric?.isEmpty == false else { return nil }

        return metric?.map { metric in
            MetricDTO(width: metric.width)
        }
    }

}
