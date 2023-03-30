//
//  MockBasket.swift
//  
//
//  Created by Artem Mayer on 29.03.2023.
//

import Vapor

typealias UserId = Int

final class MockBasket {

    // MARK: - Properties

    static let shared = MockBasket()

    // MARK: - Private properties

    private var baskets: [UserId: UserBasket] = [:]

    // MARK: - Functions

    @discardableResult
    func addProduct(to userIdBasket: UserId, by productId: Int, of quantity: Int) -> Bool {
        guard let product = MockProducts.shared.products.first(where: { $0.product_id == productId }) else {
            baskets[userIdBasket]?.removeProduct(id: productId)
            return false
        }

        if let userBasket = baskets[userIdBasket] {
            userBasket.addProduct(id: product.product_id, quantity: quantity)
        } else {
            baskets[userIdBasket] = UserBasket(productId: productId, quantity: quantity)
        }

        return true
    }

    @discardableResult
    func removeProduct(userId: UserId, productId: Int) -> Bool {
        guard let userBasket = baskets[userId] else {
            return false
        }

        userBasket.removeProduct(id: productId)
        return true
    }

    @discardableResult
    func editProductQuantity(userId: UserId, productId: Int, quantity: Int) -> Bool {
        guard
            let userBasket = baskets[userId],
            let product = MockProducts.shared.products.first(where: { $0.product_id == productId })
        else {
            baskets[userId]?.removeProduct(id: productId)
            return false
        }

        userBasket.editProduct(id: product.product_id, quantity: quantity)

        return true
    }

    func getBasket(for userId: UserId) -> Basket? {
        baskets[userId]?.getBasket()
    }
    
    func clearAfterPurchase(for userId: UserId) {
        baskets.removeValue(forKey: userId)
    }


    // MARK: - Constructions

    private init() {}
}

// MARK: - UserBasket

typealias Quantity = Int
typealias ProductId = Int

final class UserBasket {

    // MARK: - Private properties

    private var basket: [ProductId: Quantity] = [:]

    // MARK: - Constructions

    init(productId: ProductId, quantity: Quantity) {
        basket[productId] = quantity
    }

    // MARK: - Functions

    @discardableResult
    func addProduct(id productId: ProductId, quantity: Quantity) -> Bool {
        if let oldQuantity = basket[productId] {
            basket[productId] = quantity + oldQuantity
        } else {
            basket[productId] = quantity
        }

        return true
    }

    @discardableResult
    func editProduct(id productId: ProductId, quantity: Quantity) -> Bool {
        guard let _ = basket[productId] else {
            return false
        }

        basket[productId] = quantity

        return true
    }

    @discardableResult
    func removeProduct(id productId: ProductId) -> Bool {
        guard let _ = basket.removeValue(forKey: productId) else {
            return false
        }

        return true
    }

    func getBasket() -> Basket {
        let basketElements = basket.reduce(into: [BasketElement]()) { partialResult, element in
            guard let product = MockProducts.shared.products.first(where: { $0.product_id == element.key }) else {
                return
            }
            partialResult.append(.init(product: product, quantity: element.value))
        }

        let basketAmount = getBasketAmount(from: basketElements)
        return Basket(amount: basketAmount, products_quantity: basketElements.count, products: basketElements)
    }

    func isExists(productId: ProductId) -> Bool {
        basket.keys.contains(where: { $0 == productId })
    }

    // MARK: - Private functions

    private func getBasketAmount(from basketElements: [BasketElement]) -> Int {
        basketElements.reduce(0) { partialResult, element in
            partialResult + element.product.product_price * element.quantity
        }
    }
}
