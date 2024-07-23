//
//  UISettings+Metric.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension MainBanner.UISettings {

    final class Metric: Model, Content, @unchecked Sendable {

        static let schema = "ui_settings_metrics"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "ui_settings_id")
        var uiSettings: MainBanner.UISettings

        @Field(key: "width")
        var width: Double

        init() {}

        init(id: UUID? = nil, uiSettingsID: MainBanner.UISettings.IDValue, width: Double) {
            self.id = id
            self.$uiSettings.id = uiSettingsID
            self.width = width
        }

        enum CodingKeys: String, CodingKey {
            case id
            case uiSettings = "ui_settings"
            case width
        }

    }

}
