//
//  OrderController.swift
//
//
//  Created by Artem Mayer on 18.08.2024.
//

import Vapor

struct OrderController: RouteCollection {

    let orderRepository: OrderRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {

        let checkout = routes
            .grouped("api", "v1", "checkout")
            .grouped(Token.authenticator(), User.guardMiddleware())

        let orders = routes
            .grouped("api", "v1", "orders")
            .grouped(Token.authenticator(), User.guardMiddleware())

        checkout.get("available_deliveries", use: getAvailableDeliveries)
        checkout.get("available_dates", use: getAvailableDates)
        checkout.post("check_availability_and_calculate_amount", use: checkAvailabilityAndAmount)
        checkout.post("available_payments", use: getAvailablePayments)
        checkout.post("purchase", use: purchaseOrder)

        orders.get("", use: getOrders)
        orders.get(":order_number", use: getOrder)
        orders.post(":order_number", "cancel", use: cancelOrder)
        orders.post(":order_number", "repeat", use: repeatOrder)
    }

    @Sendable func getAvailableDeliveries(_ request: Request) async throws -> [AvailableDeliveryDTO] {

        guard request.auth.has(User.self) else { throw ErrorFactory.unauthorized() }

        return [AvailableDeliveryDTO(type: .courier, title: "Доставка курьером", subtitle: "заказ от 500 ₽")]
    }

    @Sendable func checkAvailabilityAndAmount(_ request: Request) async throws -> CartDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        let checkoutInfo = try request.content.decode(CheckoutDTO.self)

        return try await orderRepository.checkAvailability(for: user, with: checkoutInfo)
    }

    @Sendable func getAvailableDates(_ request: Request) async throws -> [AvailableDateDTO] {

        guard request.auth.has(User.self) else { throw ErrorFactory.unauthorized() }

        guard let cityID = request.headers.first(name: "X-City-Id")?.toUUID else {
            throw ErrorFactory.badRequest(.xCityIdParameterRequired)
        }

        return try await orderRepository.getAvailableDates(for: cityID)
    }

    @Sendable func getAvailablePayments(_ request: Request) async throws -> [AvailablePaymentsDTO] {

        guard request.auth.has(User.self) else { throw ErrorFactory.unauthorized() }

        return orderRepository.getAvailablePayments()
    }

    @Sendable func purchaseOrder(_ request: Request) async throws -> PurchaseResultDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        let checkoutInfo = try request.content.decode(CheckoutDTO.self)
        let result = try await orderRepository.purchaseOrder(for: user, with: checkoutInfo)

        let futureDate = Date(timeIntervalSinceNow: 60 * 5 * 1) // Five minutes

        try await request
            .queue
            .dispatch(PayOrderJob.self,
                      .init(orderNumber: result.orderNumber),
                      maxRetryCount: 3,
                      delayUntil: futureDate)

        return result
    }

    @Sendable func getOrders(_ request: Request) async throws -> PaginationResponse<OrderDTO> {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }

        let page = try request.query.decode(PageRequest.self)

        return try await orderRepository.getOrders(for: user, with: page)
    }

    @Sendable func getOrder(_ request: Request) async throws -> OrderDTO {

        guard request.auth.has(User.self) else { throw ErrorFactory.unauthorized() }
        guard let orderNumber = request.parameters.get("order_number", as: Int.self) else {
            throw ErrorFactory.badRequest(.orderNumberRequired)
        }

        return try await orderRepository.getOrder(for: orderNumber)
    }

    @Sendable func cancelOrder(_ request: Request) async throws -> DummyResponse {

        guard request.auth.has(User.self) else { throw ErrorFactory.unauthorized() }
        guard let orderNumber = request.parameters.get("order_number", as: Int.self) else {
            throw ErrorFactory.badRequest(.orderIdRequired)
        }

        try await orderRepository.cancelOrder(for: orderNumber)

        return DummyResponse()
    }

    @Sendable func repeatOrder(_ request: Request) async throws -> CartDTO {

        guard let user = request.auth.get(User.self) else { throw ErrorFactory.unauthorized() }
        guard let orderNumber = request.parameters.get("order_number", as: Int.self) else {
            throw ErrorFactory.badRequest(.orderNumberRequired)
        }

        return try await orderRepository.repeatOrder(for: user, with: orderNumber)
    }

}
