//
//  UISettings+Metric.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension UISettings {

    final class Metric: Model, Content, @unchecked Sendable {

        static let schema = "ui_settings_metrics"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "ui_settings_id")
        var uiSettings: UISettings

        @Field(key: "width")
        var width: Double

        init() {}

        init(id: UUID? = nil, uiSettingsID: UISettings.IDValue, width: Double) {
            self.id = id
            self.$uiSettings.id = uiSettingsID
            self.width = width
        }

    }

}
