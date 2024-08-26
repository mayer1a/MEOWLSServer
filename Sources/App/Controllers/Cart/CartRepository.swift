//
//  CartRepository.swift
//  
//
//  Created by Artem Mayer on 07.08.2024.
//

import Vapor
import Fluent

protocol CartRepositoryProtocol: Sendable {

    func addCart(for user: User) async throws
    func getRawCart(for user: User) async throws -> Cart
    func getCart(for user: User) async throws -> CartDTO
    func getAnonumous(for cartRequest: CartRequest) async throws -> CartDTO
    func update(for user: User, with cartRequest: CartRequest) async throws -> CartDTO
    func applyPromocode(_ promocode: PromoCode, for user: User) async throws -> CartDTO
    func createSummaries(from cartItems: [CartItem], for cartID: UUID, in db: Database) async throws

}

final class CartRepository: CartRepositoryProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    // MARK: - Add new cart for new user

    func addCart(for user: User) async throws {
        try await Cart(userID: try user.requireID())
            .save(on: database)
    }

    // MARK: - Get user cart

    func getCart(for user: User) async throws -> CartDTO {
        let userCart = try await getRawCart(for: user)
        return try DTOFactory.makeCart(from: userCart)
    }

    func getRawCart(for user: User) async throws -> Cart {
        try await getRaw(for: user, fullModel: true)
    }

    func getAnonumous(for cartRequest: CartRequest) async throws -> CartDTO {
        let tempUser = try await createTemporaryUserAndCart()

        do {
            let tempCartDTO = try await update(for: tempUser, with: cartRequest)
            deleteTemporaryUser(tempUser)
            return tempCartDTO
        } catch {
            deleteTemporaryUser(tempUser)
            throw error
        }
    }

    private func createTemporaryUserAndCart() async throws -> User {
        try await database.transaction { transaction in
            let tempUser = User(role: .user)
            try await tempUser.save(on: transaction)

            let tempCart = Cart(userID: try tempUser.requireID())
            try await tempCart.save(on: transaction)

            return tempUser
        }
    }

    private func deleteTemporaryUser(_ tempUser: User) {
        Task(priority: .background) { [weak self] in
            guard let self else { return }

            do {
                try await tempUser.delete(on: self.database)
            } catch {
                try await tempUser.delete(force: true, on: self.database)
            }
        }
    }

    private func getRaw(for user: User, fullModel: Bool) async throws -> Cart {
        let cart = try await Cart.query(on: database)
            .filter(\.$user.$id == user.requireID())
            .limit(1)
            .with(\.$promoCodes)
            .with(\.$summaries)
            .with(\.$items, { item in
                if fullModel {
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
                }
            })
            .first()

        guard let cart else { throw ErrorFactory.internalError(.failedToFindUserCart) }

        return cart
    }

    // MARK: - Update user cart

    func update(for user: User, with cartRequest: CartRequest) async throws -> CartDTO {
        let userCart = try await getRaw(for: user, fullModel: false)

        let newCartItems = try await self.getNewCartItems(cartRequest, from: userCart)

        try await addProducts(to: userCart, from: newCartItems)

        var updatedCart = try await getRawCart(for: user)

        _ = try await createSummaries(from: updatedCart.items, for: updatedCart.requireID(), in: database)

        updatedCart = try await getRawCart(for: user)

        let userCartDTO = try DTOFactory.makeCart(from: updatedCart)

        return userCartDTO
    }

    // MARK: - Apply promocode to user cart

    func applyPromocode(_ promocode: PromoCode, for user: User) async throws -> CartDTO {
        return CartDTO(id: .generateRandom(), items: [])
    }

    // MARK: - Create summaries

    func createSummaries(from cartItems: [CartItem], for cartID: UUID, in db: Database) async throws {
        let (originalPrice, price) = try cartItems.reduce((0.0, 0.0)) { partialResult, item in
            let amount = try makeItemAmount(for: item)
            return (partialResult.0 + amount.originalPrice, partialResult.1 + amount.price)
        }

        try await Summary.query(on: db).filter(\.$cart.$id == cartID).delete()

        try await SummaryType.allCases.asyncForEach { type in

            switch type {
            case .itemsWithoutDiscount:
                guard originalPrice > 0 else { break }

                let summary = Summary(cartID: cartID, name: type.description, value: originalPrice, type: type)
                try await summary.save(on: db)

            case .discount:
                let discount = originalPrice - price

                guard discount > 0 else { break }

                let summary = Summary(cartID: cartID, name: type.description, value: originalPrice - price, type: type)
                try await summary.save(on: db)

            case .total:
                let summary = Summary(cartID: cartID, name: type.description, value: price, type: type)
                try await summary.save(on: db)

            case .delivery, .promoDiscount:
                break

            }
        }
    }

    func makeItemAmount(for item: CartItem) throws -> Price {
        guard let price = item.product.variants.first(where: { $0.article == item.article })?.price else {
            throw ErrorFactory.internalError(.failedToFindProductPrice)
        }
        return Price(originalPrice: price.originalPrice * Double(item.count),
                     discount: price.discount,
                     price: price.price * Double(item.count))
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

        guard let productVariant else { throw ErrorFactory.internalError(.productVariantNotFound) }

        guard let info = productVariant.availabilityInfo, info.count >= cartItem.count else {
            throw ErrorFactory.badRequest(.productUnavailable)
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
            throw ErrorFactory.badRequest(.oneProductUnavailable, failures: [
                .unavailableProduct(name: product?.name, quantity: cartItem.count)
            ])
        }

        cart.items[itemIndex].count = cartItem.count
        _ = try await cart.items[itemIndex].update(on: transaction)

        return true
    }

    // MARK: - Remove item from user cart

    private func removeItem(_ request: CartRequest, from cart: Cart, in transaction: Database) async throws {
        let cartRequestArticles: Set<String> = Set(request.cart.items.map({ $0.article }))

        try await cart.items
            .filter({
                !cartRequestArticles.contains($0.article)
            })
            .asyncForEach { item in
                try await item.delete(on: transaction)
            }
    }

}
