//
//  DTOBuilder+Products.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOBuilder {

    // MARK: - Product

    static func makeProducts(from products: [Product]) async throws -> [ProductDTO]? {

        guard !products.isEmpty else { return nil }

        return try await products.asyncMap { product in

            var image: [ImageDTO] = []

            if let imageDTO = makeImage(from: product.images.first) {
                image = [imageDTO]
            }

            return ProductDTO(id: try product.requireID(),
                              name: product.name,
                              code: product.code,
                              images: image,
                              allowQuickBuy: product.allowQuickBuy,
                              variants: try await makeProductVariants(from: product.variants),
                              defaultVariantArticle: product.defaultVariantArticle)
        }
    }

    static func makeProduct(from product: Product) async throws -> ProductDTO {

        var productProperties: Set<ProductProperty> = []

        await product.variants.asyncForEach { productVariant in

            await productVariant.propertyValues.asyncForEach { propertyValue in

                productProperties.insert(propertyValue.productProperty)
            }
        }

        return ProductDTO(id: try product.requireID(),
                          name: product.name,
                          code: product.code,
                          images: await makeImages(from: product.images) ?? [],
                          allowQuickBuy: product.allowQuickBuy,
                          variants: try await makeProductVariants(from: product.variants, fullModel: true),
                          productProperties: try await makeProductProperties(from: Array(productProperties)),
                          defaultVariantArticle: product.defaultVariantArticle,
                          deliveryConditionsURL: product.deliveryConditionsURL,
                          sections: try await makeSections(from: product.sections))
    }

    // MARK: - ProductVariant

    static func makeProductVariants(from productVariants: [ProductVariant],
                                    fullModel: Bool = false) async throws -> [ProductVariantDTO] {

        try await productVariants.asyncMap { productVariant in

            let propertyValues = fullModel ? try await makePropertyValues(from: productVariant.propertyValues) : nil

            return ProductVariantDTO(id: try productVariant.requireID(),
                                     article: productVariant.article,
                                     shortName: productVariant.shortName,
                                     price: try makePrice(from: productVariant.price),
                                     availabilityInfo: try makeAvailabilityInfo(from: productVariant.availabilityInfo),
                                     badges: await makeBadge(from: productVariant.badges),
                                     propertyValues: propertyValues)

        }
    }

    // MARK: - Price

    static func makePrice(from price: Price?) throws -> PriceDTO {

        guard let price else { throw DTOBuilder.Error.make(.getBannerPriceError) }

        return PriceDTO(originalPrice: price.originalPrice, discount: price.discount, price: price.price)
    }

    // MARK: - AvailabilityInfo

    static func makeAvailabilityInfo(from info: AvailabilityInfo?) throws -> AvailabilityInfoDTO {

        guard let info else { throw DTOBuilder.Error.make(.getBannerAvailabilityInfoError) }

        return AvailabilityInfoDTO(type: info.type, deliveryDuration: info.deliveryDuration, count: info.count)
    }

    // MARK: - Badge

    static func makeBadge(from badges: [Badge]) async -> [BadgeDTO] {

        await badges.asyncMap { badge in

            BadgeDTO(title: badge.title,
                     text: badge.text,
                     backgroundColor: badge.backgroundColor,
                     tintColor: badge.tintColor)
        }
    }

    // MARK: - PropertyValue

    static func makePropertyValues(from propertyValues: [PropertyValue]) async throws -> [PropertyValueDTO] {

        try await propertyValues.asyncMap { value in

            PropertyValueDTO(id: try value.requireID(),
                             propertyID: try value.productProperty.requireID(),
                             value: value.value)
        }
    }

    static func makeProductProperties(from productProperties: [ProductProperty]) async throws -> [ProductPropertyDTO] {

        try await productProperties.asyncMap { productProperty in

            ProductPropertyDTO(id: try productProperty.requireID(),
                               name: productProperty.name,
                               code: productProperty.code,
                               selectable: productProperty.selectable)
        }
    }

    // MARK: - Section

    static func makeSections(from sections: [Section]) async throws -> [SectionDTO] {

        await sections.asyncMap { section in
            
            SectionDTO(title: section.title, type: section.type, text: section.text, link: section.link)
        }
    }

}
