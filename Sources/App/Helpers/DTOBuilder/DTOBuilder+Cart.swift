//
//  DTOBuilder+Cart.swift
//  
//
//  Created by Artem Mayer on 07.08.2024.
//

import Vapor

extension DTOBuilder {

    // MARK: - Cart

    static func makeCart(from userCart: Cart) async throws -> CartDTO {

        let itemsDTO = userCart.$items.value != nil ? try await makeCartItems(from: userCart.items) : []
        let (summaries, total) = await makeSummaries(for: itemsDTO)

        return CartDTO(id: try userCart.requireID(),
                       items: itemsDTO,
                       promoCode: nil,
                       itemsSummary: summaries,
                       total: total)
    }

    // MARK: - CartItem

    static func makeCartItems(from items: [CartItem]) async throws -> [CartItemDTO] {

        try await items.asyncMap { item in

            try await makeCartItem(from: item)
        }
    }

    static func makeCartItem(from item: CartItem) async throws -> CartItemDTO {

        guard let variant = item.product.variants.first(where: { $0.article == item.article }) else {
            throw ErrorFactory.internalError(.productVariantNotFound)
        }

        let availabilityInfo = try makeAvailabilityInfo(from: variant.availabilityInfo)
        let price = try makePrice(from: variant.price)
        let image = makeImage(from: item.product.images.first)
        let badges = await makeBadge(from: variant.badges)

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

    private enum SummaryType: String, CaseIterable {
        case itemsWithoutDiscount = "Товары без скидки"
        case discount = "Размер скидки"
        case promoDiscount = "Промокод"
        case total = "Итого:"
    }

    private static func makeSummaries(for items: [CartItemDTO]) async -> (summaries: [SummaryDTO], total: SummaryDTO) {

        let (originalPrice, price) = items.reduce((0.0, 0.0)) { partialResult, item in

            (partialResult.0 + item.amount.originalPrice, partialResult.1 + item.amount.price)
        }

        let summaries = SummaryType.allCases.compactMap { type in

            switch type {
            case .itemsWithoutDiscount:
                return originalPrice > 0 ? SummaryDTO(name: type.rawValue, value: originalPrice) : nil

            case .discount:
                let discount = originalPrice - price
                return discount > 0 ? SummaryDTO(name: type.rawValue, value: discount) : nil

            case .promoDiscount, .total:
                return nil

            }
        }

        let total = SummaryDTO(name: SummaryType.total.rawValue, value: price)

        return (summaries, total)
    }

    // MARK: - Price(Amount)

    private static func makeAmout(for price: PriceDTO, itemsCount: Int) -> PriceDTO {

        PriceDTO(originalPrice: price.originalPrice * Double(itemsCount),
                 discount: price.discount,
                 price: price.price * Double(itemsCount))
    }

}
