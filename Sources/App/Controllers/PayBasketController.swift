//
//  PayBasketController.swift
//  
//
//  Created by Artem Mayer on 01.03.2023.
//

import Vapor

// MARK: - PayBasketController

class PayBasketController {

    // MARK: - Functions

    func emulatedBankRequest(purchaseAmount: Int) -> Bool {
        purchaseAmount <= 47500
    }

    func pay(_ req: Request) throws -> EventLoopFuture<PayBasketResponse> {
        let emulatedBasketAmount = 46000
        let isBasketPaid = emulatedBankRequest(purchaseAmount: emulatedBasketAmount)
        var response: PayBasketResponse

        if isBasketPaid {
            response = PayBasketResponse(
                result: 1,
                user_message: "Вы успешно оплатили покупки! Детальная информация выслана на Вашу почту")
        } else {
            response = PayBasketResponse(
                result: 0,
                error_message: "Оплата покупки завершилась отказом")
        }

        return req.eventLoop.future(response)
    }
}

