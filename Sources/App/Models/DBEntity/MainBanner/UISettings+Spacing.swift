//
//  UISettings+Spacing.swift
//  
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension MainBanner.UISettings {

    final class Spacing: Model, Content, @unchecked Sendable {

        static let schema = "ui_settings_spacings"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "ui_settings_id")
        var uiSettings: MainBanner.UISettings

        @Field(key: "top")
        var top: Int

        @Field(key: "bottom")
        var bottom: Int

        init() {}

        init(id: UUID? = nil, uiSettingsID: MainBanner.UISettings.IDValue, top: Int, bottom: Int) {
            self.id = id
            self.$uiSettings.id = uiSettingsID
            self.top = top
            self.bottom = bottom
        }

    }

}
