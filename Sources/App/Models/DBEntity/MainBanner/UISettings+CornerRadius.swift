//
//  UISettings+CornerRadius.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension UISettings {

    final class CornerRadius: Model, Content, @unchecked Sendable {

        static let schema = "ui_settings_corner_radiuses"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "ui_settings_id")
        var uiSettings: UISettings

        @Field(key: "top_left")
        var topLeft: Int

        @Field(key: "top_right")
        var topRight: Int

        @Field(key: "bottom_left")
        var bottomLeft: Int

        @Field(key: "bottom_right")
        var bottomRight: Int

        init() {}

        init(id: UUID? = nil,
             uiSettingsID: UISettings.IDValue,
             topLeft: Int,
             topRight: Int,
             bottomLeft: Int,
             bottomRight: Int) {

            self.id = id
            self.$uiSettings.id = uiSettingsID
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }

    }

}

