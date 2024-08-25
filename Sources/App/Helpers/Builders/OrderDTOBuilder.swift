//
//  OrderDTOBuilder.swift
//
//
//  Created by Artem Mayer on 24.08.2024.
//

import Foundation

final class OrderDTOBuilder {

    private var id: UUID?
    private var number: Int?
    private var statusCode: StatusCode?
    private var status: String?
    private var canBePaidOnline: Bool = false
    private var paid: Bool = false
    private var orderDate: String?
    private var cancelable: Bool = false
    private var repeatAllowed: Bool = false
    private var client: User.PublicDTO?
    private var delivery: DeliveryDTO?
    private var comment: String?
    private var paymentType: PaymentType?
    private var items: [CartItemDTO]?
    private var summaries: [SummaryDTO]?
    private var itemsPreviews: [OrderDTO.Preview]?

    func setId(_ id: UUID) -> OrderDTOBuilder {
        self.id = id
        return self
    }

    func setNumber(_ number: Int) -> OrderDTOBuilder {
        self.number = number
        return self
    }

    func setStatusCode(_ statusCode: StatusCode) -> OrderDTOBuilder {
        self.statusCode = statusCode
        return self
    }

    func setStatus(_ status: String) -> OrderDTOBuilder {
        self.status = status
        return self
    }

    func setCanBePaidOnline(_ canBePaidOnline: Bool) -> OrderDTOBuilder {
        self.canBePaidOnline = canBePaidOnline
        return self
    }

    func setPaid(_ paid: Bool) -> OrderDTOBuilder {
        self.paid = paid
        return self
    }

    func setOrderDate(_ orderDate: String) -> OrderDTOBuilder {
        self.orderDate = orderDate
        return self
    }

    func setCancelable(_ cancelable: Bool) -> OrderDTOBuilder {
        self.cancelable = cancelable
        return self
    }

    func setRepeatAllowed(_ repeatAllowed: Bool) -> OrderDTOBuilder {
        self.repeatAllowed = repeatAllowed
        return self
    }

    func setClient(_ client: User.PublicDTO?) -> OrderDTOBuilder {
        self.client = client
        return self
    }

    func setDelivery(_ delivery: DeliveryDTO?) -> OrderDTOBuilder {
        self.delivery = delivery
        return self
    }

    func setComment(_ comment: String?) -> OrderDTOBuilder {
        self.comment = comment
        return self
    }

    func setPaymentType(_ paymentType: PaymentType?) -> OrderDTOBuilder {
        self.paymentType = paymentType
        return self
    }

    func setItems(_ items: [CartItemDTO]?) -> OrderDTOBuilder {
        self.items = items
        return self
    }

    func setSummaries(_ summaries: [SummaryDTO]?) -> OrderDTOBuilder {
        self.summaries = summaries
        return self
    }

    func setItemsPreviews(_ itemsPreviews: [OrderDTO.Preview]?) -> OrderDTOBuilder {
        self.itemsPreviews = itemsPreviews
        return self
    }

    func build() throws -> OrderDTO {
        guard let id else { throw ErrorFactory.badRequest(.orderIdRequired) }
        guard let number else { throw ErrorFactory.badRequest(.orderNumberRequired) }
        guard let statusCode else { throw ErrorFactory.internalError(.statusCodeRequired) }
        guard let status else { throw ErrorFactory.internalError(.statusRequired) }
        guard let orderDate else { throw ErrorFactory.internalError(.orderDateRequired) }

        return OrderDTO(id: id,
                        number: number,
                        statusCode: statusCode,
                        status: status,
                        canBePaidOnline: canBePaidOnline,
                        paid: paid,
                        orderDate: orderDate,
                        cancelable: cancelable,
                        repeatAllowed: repeatAllowed,
                        client: client,
                        delivery: delivery,
                        comment: comment,
                        paymentType: paymentType,
                        items: items,
                        summaries: summaries,
                        itemsPreviews: itemsPreviews)
    }
    
}
