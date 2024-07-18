//
//  AvailabilityInfo.swift
//  
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor
import Fluent

final class AvailabilityInfo: Model, Content, @unchecked Sendable {

    static let schema = "availability_infos"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "product_variant_id")
    var productVariant: ProductVariant

    @Field(key: "type")
    var type: AvailabilityType

    @OptionalField(key: "delivery_duration")
    var deliveryDuration: Int?

    @Field(key: "count")
    var count: Int

    enum CodingKeys: String, CodingKey {
        case type
        case deliveryDuration = "delivery_duration"
        case count
    }

    init() {}

    init(id: UUID? = nil, productVariant: Product.IDValue, type: AvailabilityType, deliveryDuration: Int?, count: Int) {
        self.id = id
        self.$productVariant.id = productVariant
        self.type = type
        self.deliveryDuration = deliveryDuration
        self.count = count
    }

}
