//
//  MockCart.swift
//
//
//  Created by Artem Mayer on 29.03.2023.
//

import Vapor

// MARK: - Mock Cart

typealias UserId = Int

final class MockCart {

    static let shared = MockCart()

    private var carts: [UserId: UserCart] = [:]

//    @discardableResult
//    func addProduct(to userId: UserId, by productId: Int, of quantity: Int) -> Cart? {
//        guard let product = MockProducts.shared.products.first(where: { $0.product_id == productId }) else {
//            carts[userId]?.removeProduct(id: productId)
//            return nil
//        }
//
//        if let cart = carts[userId] {
//            cart.addProduct(id: product.product_id, quantity: quantity)
//        } else {
//            carts[userId] = UserCart(productId: productId, quantity: quantity)
//        }
//
//        return getCart(for: userId)
//    }

//    @discardableResult
//    func removeProduct(userId: UserId, productId: Int) -> Cart? {
//        guard let cart = carts[userId], cart.removeProduct(id: productId) else {
//            return nil
//        }
//
//        return getCart(for: userId)
//    }
//
//    @discardableResult
//    func editProductQuantity(userId: UserId, productId: Int, quantity: Int) -> Cart? {
//        guard
//            let cart = carts[userId],
//            let product = MockProducts.shared.products.first(where: { $0.product_id == productId })
//        else {
//            carts[userId]?.removeProduct(id: productId)
//            return nil
//        }
//
//        cart.editProduct(id: product.product_id, quantity: quantity)
//
//        return getCart(for: userId)
//    }

//    func getCart(for userId: UserId) -> Cart? {
//        carts[userId]?.getCart()
//    }
    
    func clearAfterPurchase(for userId: UserId) {
        carts.removeValue(forKey: userId)
    }

    private init() {}

}

// MARK: - User Cart

typealias Quantity = Int
typealias ProductId = Int

final class UserCart {

    private var cart: [ProductId: Quantity] = [:]

    init(productId: ProductId, quantity: Quantity) {
        cart[productId] = quantity
    }

    @discardableResult
    func addProduct(id productId: ProductId, quantity: Quantity) -> Bool {
        if let oldQuantity = cart[productId] {
            cart[productId] = quantity + oldQuantity
        } else {
            cart[productId] = quantity
        }

        return true
    }

    @discardableResult
    func editProduct(id productId: ProductId, quantity: Quantity) -> Bool {
        guard let _ = cart[productId] else {
            return false
        }

        cart[productId] = quantity

        return true
    }

    @discardableResult
    func removeProduct(id productId: ProductId) -> Bool {
        cart.removeValue(forKey: productId) != nil
    }

//    func getCart() -> Cart {
//        var totalQuantity = 0
//        let cartItems = cart.reduce(into: [CartItem]()) { partialResult, element in
//            guard let product = MockProducts.shared.products.first(where: { $0.product_id == element.key }) else {
//                return
//            }
//
//            partialResult.append(.init(product: product, quantity: element.value))
//            totalQuantity += element.value
//        }
//
//        let cartAmount = getCartAmount(from: cartItems)
//
//        return Cart(amount: cartAmount, products_quantity: totalQuantity, products: cartItems)
//    }

    func isExists(productId: ProductId) -> Bool {
        cart.keys.contains(where: { $0 == productId })
    }

    // MARK: - Private functions

    private func getCartAmount(from cartItems: [CartItem]) -> Int {
        0
//        cartItems.reduce(0) { partialResult, element in
//            partialResult + element.product.product_price * element.quantity
//        }
    }
}
