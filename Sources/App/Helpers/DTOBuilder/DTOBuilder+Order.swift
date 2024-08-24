//
//  DTOBuilder+Order.swift
//  
//
//  Created by Artem Mayer on 19.08.2024.
//

import Vapor

extension DTOBuilder {

    static func makeOrders(from orders: [Order]) throws -> [OrderDTO] {

        try orders.map { order in
            try makeOrder(from: order, fullModel: false)
        }
    }

    static func makeOrder(from order: Order, fullModel: Bool = true) throws -> OrderDTO {

        let isOrderCancellable = try isOrderCancellable(order)
        let isOrderRepeatable = try isOrderRepeatable(order)
        let client = fullModel ? try makeUser(from: order.user, fullModel: false) : nil
        let delivery = fullModel ? try makeDelivery(from: order.delivery) : nil
        let items = fullModel ? try makeCartItems(from: order.items) : nil
        let itemsPreviews = fullModel ? nil : try makeOrderItemsPrevies(from: order.items)

        return OrderDTO(id: try order.requireID(),
                        number: order.number,
                        statusCode: order.statusCode,
                        status: order.status,
                        canBePaidOnline: order.canBePaidOnline,
                        paid: order.paid,
                        orderDate: order.orderDate.toOrderString,
                        cancelable: isOrderCancellable,
                        repeatAllowed: isOrderRepeatable,
                        client: client,
                        delivery: delivery,
                        comment: fullModel ? order.comment : nil,
                        paymentType: fullModel ? order.paymentType : nil,
                        items: items,
                        summaries: makeSummaries(from: order.summaries),
                        itemsPreviews: itemsPreviews)
    }

    static func makeAvailableDates(for timeZone: TimeZone,
                                   timeIntervals: [DeliveryTimeInterval]) throws -> [AvailableDateDTO] {

        let currentDate = Date()

        // Get the calendar and convert the current date to the new time zone
        var calendar = Calendar.current
        calendar.timeZone = timeZone

        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMinute = calendar.component(.minute, from: currentDate)
        let timeZoneDate = calendar.date(bySettingHour: currentHour, minute: currentMinute, second: 0, of: currentDate)

        let formattedDate = (timeZoneDate ?? currentDate).toOrderString(with: timeZone)
        let currentTimeInMinutes = currentHour * 60 + currentMinute

        var availableDates: [AvailableDateDTO] = []

        for dayOffset in 0...3 {
            guard let nextDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate) else {
                continue
            }

            let startOfNextDay = calendar.startOfDay(for: nextDate)
            let dateInNewTimeZone = dayOffset == 0 ? formattedDate : startOfNextDay.toOrderString(with: timeZone)

            let availableIntervals = try makeIntervals(from: timeIntervals, with: dayOffset, currentTimeInMinutes)

            if !availableIntervals.isEmpty {
                availableDates.append(.init(date: dateInNewTimeZone, availableTimeIntervals: availableIntervals))
            }
        }

        return availableDates
    }

    private static func makeIntervals(from timeIntervals: [DeliveryTimeInterval],
                                      with offset: Int,
                                      _ currentTimeInMinutes: Int) throws -> [DeliveryTimeIntervalDTO] {

        try timeIntervals.compactMap { interval -> DeliveryTimeIntervalDTO? in

            let intervalID = try interval.requireID()
            // Need to check for current day only
            if offset == 0 {
                // Check the time to make sure it is more than 5 hours from the current time
                let fromComponents = interval.from.split(separator: ":").map { Int($0)! }
                let fromInMinutes = fromComponents[0] * 60 + fromComponents[1]

                if currentTimeInMinutes + 300 < fromInMinutes { // 300 minutes = 5 hours

                    return DeliveryTimeIntervalDTO(id: intervalID, from: String(interval.from), to: String(interval.to))
                }
            } else { // For the following days you can add all intervals
                return DeliveryTimeIntervalDTO(id: intervalID, from: String(interval.from), to: String(interval.to))
            }

            return nil
        }
    }

    private static func makeDelivery(from delivery: Delivery?) throws -> DeliveryDTO {

        guard let delivery else { throw ErrorFactory.internalError(.deliveryNotFoundForOrder) }

        return DeliveryDTO(type: delivery.type,
                           deliveryDate: delivery.deliveryDate?.toDeliveryString,
                           deliveryTimeInterval: try makeTimeInterval(from: delivery.deliveryTimeInterval),
                           address: try makeAddress(from: delivery.address, for: .order))
    }

    private static func makeTimeInterval(from timeInterval: DeliveryTimeInterval?) throws -> DeliveryTimeIntervalDTO? {

        guard let timeInterval else { return nil }

        return DeliveryTimeIntervalDTO(id: try timeInterval.requireID(), from: timeInterval.from, to: timeInterval.to)
    }

    private static func isOrderCancellable(_ order: Order) throws -> Bool {

        switch order.statusCode {
        case .canceled, .completed:
            return false

        case .inProgress:
            return true

        }
    }

    private static func isOrderRepeatable(_ order: Order) throws -> Bool {

        let hasUnavailableItems = order.items.contains { item in
            guard
                let variant = item.product.variants.first(where: { $0.article == item.article }),
                let availabilityInfo = variant.availabilityInfo
            else {
                return true
            }

            return item.count > availabilityInfo.count
        }

        return !hasUnavailableItems
    }

    private static func makeOrderItemsPrevies(from items: [CartItem]) throws -> [OrderDTO.Preview] {

        try items.map { item in
            try OrderDTO.Preview(id: item.requireID(), image: makeImage(from: item.product.images.first))
        }
    }

}
