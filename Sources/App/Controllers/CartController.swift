//
//  CartController.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - CartController

//final class CartController: RouteCollection {
//
//    func boot(routes: RoutesBuilder) throws {
//        let builder = routes.grouped("cart")
//        builder.get(use: userCart)
//        builder.post("add-product", use: addProduct)
//        builder.post("remove-product", use: removeProduct)
//        builder.post("edit-product", use: editProductQuantity)
//        builder.post("pay-basket", use: pay)
////        builder.group(":todoID") { todo in
////            todo.delete(use: delete)
////        }
//    }
//
//    private func addProduct(_ req: Request) throws -> EventLoopFuture<CartResponse> {
//        guard let model = try? req.content.decode(AddProductRequest.self) else {
//            throw Abort(.badRequest)
//        }
//
//        print(model)
//
//        guard model.basket_element.quantity > 0 else {
//            let response = CartResponse(result: 0,
//                                        error_message: "Количество добавляемого товара должно быть больше 0!")
//            return req.eventLoop.future(response)
//        }
//        
//        let element = model.basket_element
//        let cart: Cart? = nil
////        MockCart.shared.addProduct(to: model.user_id,
////                                              by: element.product.product_id,
////                                              of: element.quantity)
//
//        guard let cart else {
//            let response = CartResponse(result: 0, error_message: "Товар отсутствует на складе!")
//            return req.eventLoop.future(response)
//        }
//
//        let response = CartResponse(result: 1, cart: cart)
//        return req.eventLoop.future(response)
//    }
//
//    private func removeProduct(_ req: Request) throws -> EventLoopFuture<CartResponse> {
//        guard let model = try? req.content.decode(RemoveProductRequest.self) else {
//            throw Abort(.badRequest)
//        }
//
//        print(model)
//        
//        let cart: Cart? = nil //MockCart.shared.removeProduct(userId: model.user_id, productId: model.product_id)
//
//        guard let cart else {
//            let response = CartResponse(result: 0, error_message: "Товар отсутствует в корзине!")
//            return req.eventLoop.future(response)
//        }
//
//        let response = CartResponse(result: 1, cart: cart)
//        return req.eventLoop.future(response)
//    }
//
//    private func editProductQuantity(_ req: Request) throws -> EventLoopFuture<CartResponse> {
//        guard let model = try? req.content.decode(EditProductRequest.self) else {
//            throw Abort(.badRequest)
//        }
//
//        print(model)
//
//        let element = model.basket_element
//        let cart: Cart? = nil // MockCart.shared.editProductQuantity(userId: model.user_id,
//                              //                                     productId: element.product.product_id,
//                              //                                     quantity: element.quantity)
//
//        guard let cart else {
//            let response = CartResponse(result: 0, error_message: "Товар отсутствует в корзине!")
//            return req.eventLoop.future(response)
//        }
//
//        let response = CartResponse(result: 1, cart: cart)
//        return req.eventLoop.future(response)
//    }
//
//    private func userCart(_ req: Request) throws -> EventLoopFuture<CartResponse> {
//        guard let model = try? req.query.decode(CartRequest.self) else {
//            throw Abort(.badRequest)
//        }
//
//        print(model)
//
//        guard let cart: Cart? = nil /*MockCart.shared.getCart(for: model.user_id)*/ else {
//            let response = CartResponse(result: 0, error_message: "Корзина не найдена!")
//            return req.eventLoop.future(response)
//        }
//
//        let response = CartResponse(result: 1, cart: cart)
//        return req.eventLoop.future(response)
//    }
//
//    private func pay(_ req: Request) throws -> EventLoopFuture<PayCartResponse> {
//        guard let model = try? req.content.decode(PayCartRequest.self) else {
//            throw Abort(.badRequest)
//        }
//
//        print(model)
//
//        guard let cart: Cart? = nil /*MockCart.shared.getCart(for: model.user_id)*/ else {
//            let response = PayCartResponse(result: 0, error_message: "Корзина не найдена!")
//            return req.eventLoop.future(response)
//        }
//
////        let isCartPaid = emulatedBankRequest(purchaseAmount: cart.amount)
//
////        guard isCartPaid else {
////            let response = PayCartResponse(result: -1, error_message: "Отказ со стороны банка!")
////            return req.eventLoop.future(response)
////        }
//
//        MockCart.shared.clearAfterPurchase(for: model.user_id)
//
//        let response = PayCartResponse(result: 1, user_message: "Покупки успешно оплачены. Чек выслан на почту.")
//
//        return req.eventLoop.future(response)
//    }
//
//    private func emulatedBankRequest(purchaseAmount: Int) -> Bool {
//        purchaseAmount <= 47500
//    }
//    
//}
