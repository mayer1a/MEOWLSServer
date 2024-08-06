//
//  UISettingsDTO+SpacingDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension UISettingsDTO {

    struct SpacingDTO: Content {
        
        let top: Int
        let bottom: Int

    }

}
