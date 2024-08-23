//
//  DTOBuilder+Products.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOBuilder {

    // MARK: - Product

    static func makeProducts(from products: [Product]) throws -> [ProductDTO]? {

        guard !products.isEmpty else { return nil }

        return try products.map { product in

            var image: [ImageDTO] = []

            if let imageDTO = makeImage(from: product.images.first) {
                image = [imageDTO]
            }

            return ProductDTO(id: try product.requireID(),
                              name: product.name,
                              code: product.code,
                              images: image,
                              allowQuickBuy: product.allowQuickBuy,
                              variants: try makeVariants(from: product.variants),
                              defaultVariantArticle: product.defaultVariantArticle)
        }
    }

    static func makeProduct(from product: Product) throws -> ProductDTO {

        var productProperties: Set<ProductProperty> = []

        product.variants.forEach { productVariant in

            productVariant.propertyValues.forEach { propertyValue in

                productProperties.insert(propertyValue.productProperty)
            }
        }

        return ProductDTO(id: try product.requireID(),
                          name: product.name,
                          code: product.code,
                          images: makeImages(from: product.images) ?? [],
                          allowQuickBuy: product.allowQuickBuy,
                          variants: try makeVariants(from: product.variants, fullModel: true),
                          productProperties: try makeProductProperties(from: Array(productProperties)),
                          defaultVariantArticle: product.defaultVariantArticle,
                          deliveryConditionsURL: product.deliveryConditionsURL,
                          sections: try makeSections(from: product.sections))
    }

    // MARK: - ProductVariant

    static func makeVariants(from variants: [ProductVariant], fullModel: Bool = false) throws -> [ProductVariantDTO] {

        try variants.map { productVariant in

            let propertyValues = fullModel ? try makePropertyValues(from: productVariant.propertyValues) : nil

            return ProductVariantDTO(id: try productVariant.requireID(),
                                     article: productVariant.article,
                                     shortName: productVariant.shortName,
                                     price: try makePrice(from: productVariant.price),
                                     availabilityInfo: try makeAvailabilityInfo(from: productVariant.availabilityInfo),
                                     badges: makeBadge(from: productVariant.badges),
                                     propertyValues: propertyValues)

        }
    }

    // MARK: - Price

    static func makePrice(from price: Price?) throws -> PriceDTO {

        guard let price else { throw ErrorFactory.internalError(.bannerProductsPriceError) }

        return PriceDTO(originalPrice: price.originalPrice, discount: price.discount, price: price.price)
    }

    // MARK: - AvailabilityInfo

    static func makeAvailabilityInfo(from info: AvailabilityInfo?) throws -> AvailabilityInfoDTO {

        guard let info else { throw ErrorFactory.internalError(.bannerProductsAvailabilityError) }

        return AvailabilityInfoDTO(type: info.type, deliveryDuration: info.deliveryDuration, count: info.count)
    }

    // MARK: - Badge

    static func makeBadge(from badges: [Badge]) -> [BadgeDTO] {

        badges.map {
            BadgeDTO(title: $0.title, text: $0.text, backgroundColor: $0.backgroundColor, tintColor: $0.tintColor)
        }
    }

    // MARK: - PropertyValue

    static func makePropertyValues(from propertyValues: [PropertyValue]) throws -> [PropertyValueDTO] {

        try propertyValues.map {
            PropertyValueDTO(id: try $0.requireID(), propertyID: try $0.productProperty.requireID(), value: $0.value)
        }
    }

    static func makeProductProperties(from productProperties: [ProductProperty]) throws -> [ProductPropertyDTO] {

        try productProperties.map {
            ProductPropertyDTO(id: try $0.requireID(), name: $0.name, code: $0.code, selectable: $0.selectable)
        }
    }

    // MARK: - Section

    static func makeSections(from sections: [Section]) throws -> [SectionDTO] {

        sections.map {
            SectionDTO(title: $0.title, type: $0.type, text: $0.text, link: $0.link)
        }
    }

}
