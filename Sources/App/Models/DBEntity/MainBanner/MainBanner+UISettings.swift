//
//  MainBanner+UISettings.swift
//  
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension MainBanner {

    final class UISettings: Model, Content, @unchecked Sendable {

        static let schema = "main_banners_ui_settings"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "main_banner_id")
        var mainBanner: MainBanner

        @OptionalField(key: "background_color")
        var backgroundColor: HEXColor?

        @OptionalChild(for: \.$uiSettings)
        var spasings: Spacing?

        @OptionalChild(for: \.$uiSettings)
        var cornerRadiuses: CornerRadius?

        @OptionalField(key: "auto_sliding_timeout")
        var autoSlidingTimeout: Int?

        @Children(for: \.$uiSettings)
        var metrics: [Metric]

        init() {}

        init(id: UUID? = nil, mainBannerID: MainBanner.IDValue, backgroundColor: HEXColor?, autoSlidingTimeout: Int?) {
            self.id = id
            self.$mainBanner.id = mainBannerID
            self.backgroundColor = backgroundColor
            self.autoSlidingTimeout = autoSlidingTimeout
        }

    }

}
