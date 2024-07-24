//
//  UISettingsDTO+CornerRadiusDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension MainBannerDTO.UISettingsDTO {

    struct CornerRadiusDTO: Content {

        let topLeft: Int
        let topRight: Int
        let bottomLeft: Int
        let bottomRight: Int

        enum CodingKeys: String, CodingKey {
            case topLeft = "top_left"
            case topRight = "top_right"
            case bottomLeft = "bottom_left"
            case bottomRight = "bottom_right"
        }

    }

}
