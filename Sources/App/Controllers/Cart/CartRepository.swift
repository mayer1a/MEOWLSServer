//
//  CartRepository.swift
//  
//
//  Created by Artem Mayer on 07.08.2024.
//

import Vapor
import Fluent

protocol CartRepositoryProtocol: Sendable {

    func get(for user: User) async throws -> CartDTO
    func update(for user: User, with cartRequest: CartRequest) async throws -> CartDTO
    func applyPromocode(_ promocode: PromoCode, for user: User) async throws -> CartDTO

}

final class CartRepository: CartRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    // MARK: - Get user cart

    func get(for user: User) async throws -> CartDTO {

        let userCart = try await Cart.query(on: database)
            .filter(\.$user.$id == user.requireID())
            .limit(1)
            .with(\.$promoCodes)
            .with(\.$items, { item in

                item
                    .with(\.$product) { product in

                        product
                            .with(\.$images)
                            .with(\.$variants) { variant in
                                variant
                                    .with(\.$price)
                                    .with(\.$availabilityInfo)
                                    .with(\.$badges)
                            }
                    }
            })
            .first()

        guard let userCart else { throw Abort(.internalServerError, reason: "User cart is nil") }

        let userCartDTO = try await DTOBuilder.makeCart(from: userCart)

        return userCartDTO
    }

    // MARK: - Update user cart

    func update(for user: User, with cartRequest: CartRequest) async throws -> CartDTO {

        let userCart = try await Cart.query(on: database)
            .filter(\.$user.$id == user.requireID())
            .limit(1)
            .with(\.$items)
            .first()

        guard let userCart else { throw Abort(.internalServerError, reason: "There is no user cart") }

        let newCartItems = try await self.getNewCartItems(cartRequest, from: userCart)

        try await addProducts(to: userCart, from: newCartItems)

        let updatedCart = try await Cart.query(on: database)
            .filter(\.$user.$id == user.requireID())
            .limit(1)
            .with(\.$items, { item in

                item
                    .with(\.$product) { product in

                        product
                            .with(\.$images)
                            .with(\.$variants) { variant in
                                variant
                                    .with(\.$price)
                                    .with(\.$availabilityInfo)
                                    .with(\.$badges)
                            }
                    }
            })
            .first()

        guard let updatedCart else { throw Abort(.internalServerError, reason: "There is no updated user cart") }

        let userCartDTO = try await DTOBuilder.makeCart(from: updatedCart)

        return userCartDTO
    }

    // MARK: - Apply promocode to user cart

    func applyPromocode(_ promocode: PromoCode, for user: User) async throws -> CartDTO {

        return CartDTO(id: .generateRandom(), items: [])
    }

    // MARK: - Get new items in user cart

    private func getNewCartItems(_ request: CartRequest, from cart: Cart) async throws -> [CartRequest.CartDTO.Item] {

        try await database.transaction { [weak self] transaction in

            guard let self else { return [] }

            try await self.removeItem(request, from: cart, in: transaction)

            return try await request.cart.items.asyncCompactMap { cartItem -> CartRequest.CartDTO.Item? in

                try await self.hasProductQuantityUpdates(for: cartItem, from: cart, in: transaction) ? nil : cartItem
            }
        }
    }

    private func addProducts(to cart: Cart, from cartItem: [CartRequest.CartDTO.Item]) async throws {

        try await cartItem.asyncForEach { item in

            try await self.addProduct(to: cart, from: item)
        }
    }

    private func addProduct(to cart: Cart, from cartItem: CartRequest.CartDTO.Item) async throws {

        let productVariant = try await ProductVariant.query(on: database)
            .filter(\.$article == cartItem.article)
            .limit(1)
            .with(\.$product, { product in
                product.with(\.$variants)
            })
            .with(\.$price)
            .with(\.$availabilityInfo)
            .first()

        guard let productVariant else { throw Abort(.internalServerError, reason: "Product variant is nil") }

        guard let info = productVariant.availabilityInfo, info.count >= cartItem.count else {
            throw Abort(.badRequest, reason: "The product for this quantity \(cartItem.count) is not available")
        }

        let cartItem = try CartItem(productID: productVariant.product.requireID(),
                                    cartID: cart.requireID(),
                                    article: cartItem.article,
                                    count: cartItem.count)

        try await cartItem.save(on: database)
    }

    // MARK: - Check product quantity and availability

    private func hasProductQuantityUpdates(for cartItem: CartRequest.CartDTO.Item,
                                           from cart: Cart,
                                           in transaction: Database) async throws -> Bool {

        guard let itemIndex = cart.items.firstIndex(where: { $0.article == cartItem.article }) else { return false }

        let product = try? await cart.items[itemIndex].$product.query(on: transaction)
            .with(\.$variants, { variant in

                variant.with(\.$availabilityInfo)
            })
            .first()

        guard
            let info = product?.variants.first(where: { $0.article == cartItem.article})?.availabilityInfo,
            info.count >= cartItem.count
        else {

            var failure: [ValidationFailure]?

            if let name = product?.name {
                failure = [
                    .init(field: "\(name)", failure: "\"\(name)\" is available in quantity \(cartItem.count) items")
                ]
            }

            throw CustomError(.badRequest,
                              code: "incorrectProductQuantity",
                              reason: "One of the products is not available for order in such quantity",
                              failures: failure)
        }

        cart.items[itemIndex].count = cartItem.count
        _ = try await cart.items[itemIndex].update(on: transaction)

        return true
    }

    // MARK: - Remove item from user cart

    private func removeItem(_ request: CartRequest, from cart: Cart, in transaction: Database) async throws {

        let cartRequestArticles: Set<String> = Set(request.cart.items.map({ $0.article }))

        let differenceItems = cart.items.filter { !cartRequestArticles.contains($0.article) }

        let cartItems = cart.$items.value

        try await cartItems?.enumerated().asyncForEach { index, item in

            if differenceItems.contains(where: { $0.id == item.id }) {
                try await item.delete(on: transaction)
            }
        }
    }

}
