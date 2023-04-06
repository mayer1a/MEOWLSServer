//
//  BasketController.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - BasketController

final class BasketController {

    // MARK: - Functions

    func addProduct(_ req: Request) throws -> EventLoopFuture<GetBasketResponse> {
        guard let model = try? req.content.decode(AddProductRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        guard model.basket_element.quantity > 0 else {
            let response = GetBasketResponse(result: 0, error_message: "Количество добавляемого товара должно быть больше 0!")
            return req.eventLoop.future(response)
        }
        
        let element = model.basket_element
        let userBasket = MockBasket.shared.addProduct(
            to: model.user_id,
            by: element.product.product_id,
            of: element.quantity)

        guard let userBasket else {
            let response = GetBasketResponse(result: 0, error_message: "Товар отсутствует на складе!")
            return req.eventLoop.future(response)
        }

        let response = GetBasketResponse(result: 1, basket: userBasket)
        return req.eventLoop.future(response)
    }

    func removeProduct(_ req: Request) throws -> EventLoopFuture<GetBasketResponse> {
        guard let model = try? req.content.decode(RemoveProductRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)
        
        let userBasket = MockBasket.shared.removeProduct(userId: model.user_id, productId: model.product_id)

        guard let userBasket else {
            let response = GetBasketResponse(result: 0, error_message: "Товар отсутствует в корзине!")
            return req.eventLoop.future(response)
        }

        let response = GetBasketResponse(result: 1, basket: userBasket)
        return req.eventLoop.future(response)
    }

    func editProductQuantity(_ req: Request) throws -> EventLoopFuture<GetBasketResponse> {
        guard let model = try? req.content.decode(EditProductRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        let element = model.basket_element
        let userBasket = MockBasket.shared.editProductQuantity(
            userId: model.user_id,
            productId: element.product.product_id,
            quantity: element.quantity)

        guard let userBasket else {
            let response = GetBasketResponse(result: 0, error_message: "Товар отсутствует в корзине!")
            return req.eventLoop.future(response)
        }

        let response = GetBasketResponse(result: 1, basket: userBasket)
        return req.eventLoop.future(response)
    }

    func getUserBasket(_ req: Request) throws -> EventLoopFuture<GetBasketResponse> {
        guard let model = try? req.query.decode(GetBasketRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        guard let userBasket = MockBasket.shared.getBasket(for: model.user_id) else {
            let response = GetBasketResponse(result: 0, error_message: "Корзина не найдена!")
            return req.eventLoop.future(response)
        }

        let response = GetBasketResponse(result: 1, basket: userBasket)
        return req.eventLoop.future(response)
    }

    func pay(_ req: Request) throws -> EventLoopFuture<PayBasketResponse> {
        guard let model = try? req.content.decode(PayBasketRequest.self) else {
            throw Abort(.badRequest)
        }

        print(model)

        guard let userBasket = MockBasket.shared.getBasket(for: model.user_id) else {
            let response = PayBasketResponse(result: 0, error_message: "Корзина не найдена!")
            return req.eventLoop.future(response)
        }

        let isBasketPaid = emulatedBankRequest(purchaseAmount: userBasket.amount)

        guard isBasketPaid else {
            let response = PayBasketResponse(result: -1, error_message: "Отказ со стороны банка!")
            return req.eventLoop.future(response)
        }

        MockBasket.shared.clearAfterPurchase(for: model.user_id)

        let response = PayBasketResponse(result: 1, user_message: "Покупки успешно оплачены. Чек выслан на почту.")

        return req.eventLoop.future(response)
    }

    // MARK: - Private functions

    private func emulatedBankRequest(purchaseAmount: Int) -> Bool {
        purchaseAmount <= 47500
    }
}