//
//  DTOFactory+Banners.swift
//  
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOFactory {

    // MARK: - Banners

    static func makeBanners(from banners: [MainBanner], fullModel: Bool = true) throws -> [MainBannerDTO] {

        try banners.map { mainBanner in
            try makeBanner(from: mainBanner, fullModel: fullModel)
        }
    }

    static func makeBanner(from mainBanner: MainBanner, fullModel: Bool) throws -> MainBannerDTO {

        var bannerBuilder = try MainBannerDTOBuilder()
            .setId(mainBanner.requireID())
            .setTitle(mainBanner.title)
            .setRedirect(makeRedirect(from: mainBanner.redirect, fullModel: !fullModel))
            .setImage(makeImage(from: mainBanner.image))

        if fullModel {
            let bannerCategories = try mainBanner.categories.map { category in

                guard let categoryDTO = try makeCategory(from: category) else {
                    throw ErrorFactory.internalError(.bannerCategoriesError, failures: [.ID(category.id)])
                }
                return categoryDTO
            }

            let child = try makeBanners(from: mainBanner.banners, fullModel: false)

            bannerBuilder = bannerBuilder
                .setUISettings(makeUISettings(from: mainBanner.uiSettings))
                .setPlaceType(mainBanner.placeType)
                .setCategories(bannerCategories.isEmpty ? nil : bannerCategories)
                .setProducts(try makeProducts(from: mainBanner.products))
                .setBanners(child.isEmpty ? nil : child)
        }

        return try bannerBuilder.build()
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
