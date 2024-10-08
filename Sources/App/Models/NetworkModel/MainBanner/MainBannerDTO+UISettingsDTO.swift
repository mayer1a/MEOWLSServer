//
//  MainBannerDTO+UISettingsDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension MainBannerDTO {

    struct UISettingsDTO: Content {

        let backgroundColor: HEXColor?
        let spasings: SpacingDTO?
        let cornerRadiuses: CornerRadiusDTO?
        let autoSlidingTimeout: Int?
        let metrics: [MetricDTO]?

        enum CodingKeys: String, CodingKey {
            case backgroundColor = "background_color"
            case spasings
            case cornerRadiuses = "corner_radiuses"
            case autoSlidingTimeout = "auto_sliding_timeout"
            case metrics
        }

    }

}
