//
//  Sale.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class Sale: Model, Content, @unchecked Sendable {

    static let schema = "sales"

    @ID(key: .id)
    var id: UUID?

    @OptionalParent(key: "redirect_id")
    var redirect: Redirect?

    @Field(key: "code")
    var code: String

    @Enum(key: "sale_type")
    var saleType: SaleType

    @Field(key: "title")
    var title: String

    @OptionalChild(for: \.$sale)
    var image: Image?

    @Field(key: "start_date")
    var startDate: Date

    @Field(key: "end_date")
    var endDate: Date

    @Field(key: "disclaimer")
    var disclaimer: String

    @Children(for: \.$sale)
    var products: [Product]

    init() {}

    init(id: UUID? = nil,
         redirectID: Redirect.IDValue? = nil,
         code: String,
         saleType: SaleType,
         title: String,
         startDate: Date,
         endDate: Date,
         disclaimer: String) {

        self.id = id
        self.$redirect.id = redirectID
        self.code = code
        self.saleType = saleType
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.disclaimer = disclaimer
    }

}
