//
//  MainBanner.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor
import Fluent

final class MainBanner: Model, Content, @unchecked Sendable {

    static let schema = "main_banners"

    @ID(key: .id)
    var id: UUID?

    @OptionalField(key: "title")
    var title: String?

    @OptionalEnum(key: "place_type")
    var placeType: PlaceType?

    @OptionalChild(for: \.$mainBanner)
    var redirect: Redirect?

    @OptionalChild(for: \.$mainBanner)
    var uiSettings: UISettings?

    @Children(for: \.$mainBanner)
    var categories: [Category]

    @OptionalParent(key: "parent_id")
    var parent: MainBanner?

    @Children(for: \.$parent)
    var banners: [MainBanner]

    @Children(for: \.$mainBanner)
    var products: [Product]

    @OptionalChild(for: \.$mainBanner)
    var image: Image?

    init() {}

    init(id: UUID? = nil, title: String?, placeType: PlaceType?, parentID: MainBanner.IDValue? = nil) {
        self.id = id
        self.title = title
        self.placeType = placeType
        self.$parent.id = parentID
    }

}

