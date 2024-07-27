//
//  PromoCode.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor
import Fluent

final class PromoCode: Model, @unchecked Sendable {

    static let schema = "promo_codes"

    @ID(key: .id)
    var id: UUID?

    @OptionalField(key: "code")
    var code: String?

    @Field(key: "discount")
    var discount: Int

    @Enum(key: "discount_type")
    var discountType: DiscountType

    @Boolean(key: "is_active")
    var isActive: Bool

    @Field(key: "start_date")
    var startDate: Date

    @Field(key: "end_date")
    var endDate: Date

    @Siblings(through: PromoCodesProductsPivot.self, from: \.$promoCode, to: \.$product)
    var products: [Product]

    @Siblings(through: PromoCodesUsersPivot.self, from: \.$promoCode, to: \.$user)
    var usedUsers: [User]

    init() {}

    init(id: UUID? = nil, 
         code: String?,
         discount: Int,
         discountType: DiscountType,
         isActive: Bool,
         startDate: Date,
         endDate: Date) {

        self.id = id
        self.code = code
        self.discount = discount
        self.discountType = discountType
        self.isActive = isActive
        self.startDate = startDate
        self.endDate = endDate
    }

}
