//
//  DTOFactory+Cart.swift
//  
//
//  Created by Artem Mayer on 07.08.2024.
//

import Vapor

extension DTOFactory {

    // MARK: - Cart

    static func makeCart(from cart: Cart, with summaries: [Summary]? = nil, alert: String? = nil) throws -> CartDTO {

        let itemsDTO = cart.$items.value != nil ? try makeCartItems(from: cart.items) : []
        let summariesDTO: [SummaryDTO]?

        if let summaries {
            summariesDTO = makeSummaries(from: summaries)
        } else {
            summariesDTO = cart.summaries.isEmpty ? [SummaryDTO()] : makeSummaries(from: cart.summaries)
        }

        return CartDTO(id: try cart.requireID(),
                       items: itemsDTO,
                       promoCode: nil,
                       summaries: summariesDTO,
                       availabilityAlertMessage: alert)
    }

    // MARK: - CartItem

    static func makeCartItems(from items: [CartItem]) throws -> [CartItemDTO] {

        try items.map { item in
            try makeCartItem(from: item)
        }
    }

    static func makeCartItem(from item: CartItem) throws -> CartItemDTO {

        guard let variant = item.product.variants.first(where: { $0.article == item.article }) else {
            throw ErrorFactory.internalError(.productVariantNotFound)
        }

        let availabilityInfo = try makeAvailabilityInfo(from: variant.availabilityInfo)
        let price = try makePrice(from: variant.price)
        let image = makeImage(from: item.product.images.first)
        let badges = makeBadge(from: variant.badges)

        return try CartItemDTO(id: item.requireID(),
                               productID: item.product.requireID(),
                               article: item.article,
                               productName: item.product.name,
                               availabilityInfo: availabilityInfo,
                               count: item.count,
                               price: price,
                               image: image,
                               variantName: variant.shortName,
                               badges: badges,
                               amount: makeAmout(for: price, itemsCount: item.count))
    }

    // MARK: - Summary

    static func makeSummaries(from summaries: [Summary]) -> [SummaryDTO]? {

        summaries.map { summary in
            SummaryDTO(name: summary.name, value: summary.value, type: summary.type)
        }
    }

    // MARK: - Price(Amount)

    private static func makeAmout(for price: PriceDTO, itemsCount: Int) -> PriceDTO {

        PriceDTO(originalPrice: price.originalPrice * Double(itemsCount),
                 discount: price.discount,
                 price: price.price * Double(itemsCount))
    }

}
