//
//  ProductDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct ProductDTO: Content {

    let id: UUID
    let name: String
    let code: String
    /// Only one image if not for detailed product
    let images: [ImageDTO]
    let allowQuickBuy: Bool
    let variants: [ProductVariantDTO]
    /// Only for detailed product
    let productProperties: [ProductPropertyDTO]?
    let defaultVariantArticle: String?
    /// Only for detailed product if url exists
    let deliveryConditionsURL: String?
    /// Only for detailed product
    let sections: [SectionDTO]?

    enum CodingKeys: String, CodingKey {
        case id, name, code, images
        case allowQuickBuy = "allow_quick_buy"
        case variants
        case productProperties = "properties"
        case defaultVariantArticle = "default_variant_article"
        case deliveryConditionsURL = "delivery_conditions_url"
        case sections
    }

}
