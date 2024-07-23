//
//  MainBanner+Redirect.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

extension MainBanner {

    final class Redirect: Model, Content, @unchecked Sendable {

        static let schema = "main_banners_redirects"

        @ID(key: .id)
        var id: UUID?

        @Parent(key: "main_banner_id")
        var mainBanner: MainBanner

        @Enum(key: "redirect_type")
        var redirectType: RedirectType

        @OptionalChild(for: \.$redirect)
        var sale: Sale?

        @OptionalChild(for: \.$redirect)
        var productsSet: ProductsSet?

        @OptionalField(key: "url")
        var url: String?

        init() {}

        init(id: UUID? = nil, mainBannerID: MainBanner.IDValue, redirectType: RedirectType, url: String?) {
            self.id = id
            self.$mainBanner.id = mainBannerID
            self.redirectType = redirectType
            self.url = url
        }

        enum CodingKeys: String, CodingKey {
            case id
            case mainBanner = "main_banner"
            case redirectType = "redirect_type"
            case sale
            case productsSet = "products_set"
            case url
        }

    }

}
