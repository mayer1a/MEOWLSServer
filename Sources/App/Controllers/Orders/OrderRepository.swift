//
//  OrderRepository.swift
//
//
//  Created by Artem Mayer on 18.08.2024.
//

import Vapor
import Fluent

protocol OrderRepositoryProtocol: Sendable {

    func checkAvailability(for user: User, with checkout: CheckoutDTO) async throws -> CartDTO
    func getAvailableDates(for cityID: City.IDValue) async throws -> [AvailableDateDTO]
    func getAvailablePayments() -> [AvailablePaymentsDTO]
    func purchaseOrder(for user: User, with checkoutInfo: CheckoutDTO) async throws -> PurchaseResultDTO
    
    func getOrders(for user: User, with page: PageRequest) async throws -> PaginationResponse<OrderDTO>
    func getOrder(for orderNumber: Int) async throws -> OrderDTO
    func cancelOrder(for orderNumber: Int) async throws
    func repeatOrder(for user: User, with orderNumber: Int) async throws -> CartDTO

}

final class OrderRepository: OrderRepositoryProtocol {

    private let database: Database
    private let cartRepository: CartRepositoryProtocol

    init(database: Database, cartRepository: CartRepositoryProtocol) {
        self.database = database
        self.cartRepository = cartRepository
    }

    func checkAvailability(for user: User, with checkoutInfo: CheckoutDTO) async throws -> CartDTO {
        let userCart = try await cartRepository.getRawCart(for: user)

        let alertMessage = userCart.items.contains { cartItem in
            guard
                let variant = cartItem.product.variants.first(where: { $0.article == cartItem.article }),
                let realAvailabilityCount = variant.availabilityInfo?.count
            else {
                return true
            }
            return cartItem.count > realAvailabilityCount
        } ? "Некоторые товары из Вашей корзины больше недоступны в указанном количестве" : nil

        let summaries = try appendDeliverySummary(for: userCart).orderSummaries
        return try DTOFactory.makeCart(from: userCart, with: summaries, alert: alertMessage)
    }

    func getAvailableDates(for cityID: City.IDValue) async throws -> [AvailableDateDTO] {
        try await fetchAvailableDates(for: cityID, in: database)
    }

    func getAvailablePayments() -> [AvailablePaymentsDTO] {
        PaymentType.allCases.map {
            AvailablePaymentsDTO(type: $0, title: $0.description.title, subtitle: $0.description.subtitle)
        }
    }

    func purchaseOrder(for user: User, with checkoutInfo: CheckoutDTO) async throws -> PurchaseResultDTO {
        let userCart = try await cartRepository.getRawCart(for: user)
        let order = try await makeOrder(for: user, with: userCart, checkoutInfo)
        return PurchaseResultDTO(orderNumber: "\(order.number)")
    }

    func getOrders(for user: User, with page: PageRequest) async throws -> PaginationResponse<OrderDTO> {
        let paginationOrders = try await Order.query(on: database)
            .filter(\.$user.$id == user.requireID())
            .sort(\.$orderDate, .descending)
            .sort(\.$number, .descending)
            .with(\.$items, { item in
                item.with(\.$product) { product in
                    product
                        .with(\.$images)
                        .with(\.$variants) { variant in
                            variant.with(\.$availabilityInfo)
                        }
                }
            })
            .with(\.$summaries)
            .paginate(with: page)

        let ordersDTO = try DTOFactory.makeOrders(from: paginationOrders.results)

        return PaginationResponse(results: ordersDTO, paginationInfo: paginationOrders.paginationInfo)
    }

    func getOrder(for orderNumber: Int) async throws -> OrderDTO {
        let order = try await getRawOrder(for: orderNumber, fullLoad: true)
        return try DTOFactory.makeOrder(from: order)
    }

    func cancelOrder(for orderNumber: Int) async throws {
        let order = try await getRawOrder(for: orderNumber, fullLoad: false)

        switch order.statusCode {
        case .canceled: throw ErrorFactory.badRequest(.orderAlreadyCancelled)
        case .completed: throw ErrorFactory.badRequest(.orderIsComplete)
        case .inProgress: break
        }

        try await database.transaction { [weak self] transaction in
            guard let self else { throw ErrorFactory.serviceUnavailable(failures: [.databaseConnection]) }

            try await updateAvailabilityInfo(for: order.items, revert: true, in: transaction)

            order.statusCode = .canceled
            order.status = order.statusCode.getStatus()

            try await order.update(on: transaction)
        }
    }

    func repeatOrder(for user: User, with orderNumber: Int) async throws -> CartDTO {
        let cart = try await cartRepository.getRawCart(for: user)
        var orderItems = try await getRawOrder(for: orderNumber, fullLoad: false).items

        let items = cart.items.compactMap { item -> CartRequestItem? in

            if let orderItem = orderItems.enumerated().first(where: { $1.article == item.article }) {

                orderItems.remove(at: orderItem.offset)

                let countSum = item.count + orderItem.element.count
                let variant = orderItem.element.product.variants.first { $0.article == orderItem.element.article }

                guard let availableCount = variant?.availabilityInfo?.count else { return nil }

                return .init(article: item.article, count: min(countSum, availableCount))
            } else {
                return .init(article: item.article, count: item.count)
            }
        }

        let newItems: [CartRequestItem] = orderItems.compactMap {

            let availableCount = $0.product.variants.first { $0.article == $0.article }?.availabilityInfo?.count ?? 0
            return availableCount >= $0.count ? .init(article: $0.article, count: $0.count) : nil
        }

        let cartRequest = CartRequest(cart: .init(items: items + newItems), promoCode: nil)
        return try await cartRepository.update(for: user, with: cartRequest)
    }

    private func makeOrder(for user: User,
                           with cart: Cart,
                           _ checkoutInfo: CheckoutDTO) async throws -> Order {

        try await database.transaction { [weak self] transaction in
            guard let self else { throw ErrorFactory.serviceUnavailable(failures: [.databaseConnection]) }

            try await updateAvailabilityInfo(for: cart.items, revert: false, in: transaction)

            let order = try await saveOrder(for: user, with: checkoutInfo, in: transaction)

            try await self.createDelivery(with: checkoutInfo, for: order, in: transaction)
            try await self.updateItemsParent(for: cart.items, with: order.requireID(), in: transaction)
            try await self.updateSummariesParent(for: cart, with: order.requireID(), in: transaction)

            return order
        }
    }

    private func updateAvailabilityInfo(for items: [CartItem], revert: Bool, in db: Database) async throws {
        try await items.asyncForEach { item in
            guard
                let variant = item.product.variants.first(where: { $0.article == item.article }),
                let availabilityInfo = variant.availabilityInfo,
                (item.count <= availabilityInfo.count || revert)
            else {
                throw ErrorFactory.badRequest(.itemsNotAvailableWithSetCount)
            }

            let sign = revert ? -1 : 1
            variant.availabilityInfo?.count = availabilityInfo.count - item.count * sign

            try await variant.availabilityInfo?.update(on: db)
        }
    }

    private func saveOrder(for user: User, with checkoutInfo: CheckoutDTO, in db: Database) async throws -> Order {
        guard let type = checkoutInfo.paymentType else { throw ErrorFactory.badRequest(.paymentTypeRequired) }

        // Get the current time in the selected time zone
        let currentDate = Date()
        let timeZone = try await fetchTimeZone(for: checkoutInfo.delivery.address?.city.id, in: db)

        let order = Order(userID: try user.requireID(),
                          statusCode: .inProgress,
                          status: StatusCode.inProgress.getStatus(),
                          canBePaidOnline: false,
                          paid: false,
                          orderDate: currentDate.toTimeZoneDate(with: timeZone) ?? currentDate,
                          comment: checkoutInfo.comment,
                          paymentType: type)

        try await order.save(on: db)

        guard let order = try await Order.find(order.requireID(), on: db) else {
            throw ErrorFactory.internalError(.orderCreationFailed)
        }

        return order
    }

    private func createDelivery(with checkoutInfo: CheckoutDTO, for order: Order, in db: Database) async throws {
        guard
            let cityID = checkoutInfo.delivery.address?.city.id,
            let timeIntervalID = checkoutInfo.delivery.deliveryTimeInterval?.id,
            let dateString = checkoutInfo.delivery.deliveryDate,
            let orderDate = dateString.toDeliveryDate?.toOrderString,
            let date = dateString.toDeliveryDate
        else {
            throw ErrorFactory.badRequest(.deliveryCreationFailed)
        }

        let selectedDate = try await fetchAvailableDates(for: cityID, in: db).first(where: { $0.date == orderDate })

        guard
            let selectedDate,
            selectedDate.availableTimeIntervals.contains(where: { $0.id == timeIntervalID })
        else {
            throw ErrorFactory.badRequest(.deliveryTimeIntervalNotAvailable)
        }

        let delivery = Delivery(deliveryTimeIntervalID: timeIntervalID,
                                orderID: try order.requireID(),
                                type: checkoutInfo.delivery.type,
                                deliveryDate: date)

        try await delivery.save(on: db)
        try await createAddress(with: checkoutInfo, for: delivery, in: db)
    }

    private func fetchTimeZone(for cityID: UUID?, in db: Database) async throws -> TimeZone {
        guard let city = try await City.find(cityID, on: db) else {
            throw ErrorFactory.badRequest(.cityNotFoundById)
        }

        return TimeZone(identifier: city.cityTimeZone)!
    }

    private func fetchAvailableDates(for cityID: UUID, in db: Database) async throws -> [AvailableDateDTO] {
        let timeZone = try await fetchTimeZone(for: cityID, in: db)
        let timeIntervals = try await DeliveryTimeInterval.query(on: db).all()
        return try DTOFactory.makeAvailableDates(for: timeZone, timeIntervals: timeIntervals)
    }

    private func createAddress(with checkoutInfo: CheckoutDTO, for delivery: Delivery, in db: Database) async throws {
        guard let requestAddress = checkoutInfo.delivery.address else {
            throw ErrorFactory.badRequest(.invalidReceivedAddress)
        }

        let address = try Address(cityID: requestAddress.city.id,
                                  deliveryID: delivery.requireID(),
                                  street: requestAddress.street,
                                  house: requestAddress.house,
                                  entrance: requestAddress.entrance,
                                  floor: requestAddress.floor,
                                  flat: requestAddress.flat,
                                  formattedString: requestAddress.format())

        try await address.save(on: db)
    }

    private func updateItemsParent(for cartItems: [CartItem], with orderID: UUID, in db: Database) async throws {
        try await cartItems.asyncForEach { cartItem in
            cartItem.$order.id = orderID
            cartItem.$cart.id = nil
            try await cartItem.update(on: db)
        }
    }

    private func updateSummariesParent(for cart: Cart, with orderID: UUID, in db: Database) async throws {
        let (orderSummaries, oldTotalSummary) = try appendDeliverySummary(for: cart)

        try await orderSummaries.asyncForEach { summary in
            var needSave = false
            if summary.$order.id == nil && summary.$cart.id == nil {
                needSave = true
            }

            summary.$order.id = orderID
            summary.$cart.id = nil
            try await needSave ? summary.save(on: db) : summary.update(on: db)
        }

        try await oldTotalSummary?.delete(on: db)
    }

    private func appendDeliverySummary(for cart: Cart) throws -> (orderSummaries: [Summary], oldTotal: Summary?) {
        let deliveryType = SummaryType.delivery
        let deliveryCost = AppConstants.shared.deliveryCost
        let deliverySummary = Summary(name: deliveryType.description, value: deliveryCost, type: deliveryType)

        guard let totalElement = cart.summaries.enumerated().first(where: { $1.type == .total }) else {
            throw ErrorFactory.internalError(.totalSummaryNotFound)
        }

        let total = totalElement.element
        let totalSummary = Summary(name: total.name, value: total.value + deliveryCost, type: total.type)

        var summaries = cart.summaries
        let oldTotal = summaries.remove(at: totalElement.offset)
        summaries.append(contentsOf: [deliverySummary, totalSummary])

        return (summaries, oldTotal)
    }

    private func getRawOrder(for orderNumber: Int, fullLoad: Bool) async throws -> Order {
        var orderQuery = Order.query(on: database)
            .filter(\.$number == orderNumber)
            .limit(1)
            .with(\.$items) { item in
                item.with(\.$product) { product in
                    product.with(\.$variants) { variant in
                        variant.with(\.$availabilityInfo)

                        if fullLoad { variant.with(\.$price).with(\.$badges) }
                    }

                    if fullLoad { product.with(\.$images) }
                }
            }

        if fullLoad {
            orderQuery = orderQuery
                .with(\.$user)
                .with(\.$delivery, { delivery in
                    delivery
                        .with(\.$deliveryTimeInterval)
                        .with(\.$address) { address in
                            address.with(\.$city).with(\.$location)
                        }
                })
                .with(\.$summaries)
        }

        guard let order = try await orderQuery.first() else { throw ErrorFactory.badRequest(.invalidOrderNumber) }

        return order
    }

}
