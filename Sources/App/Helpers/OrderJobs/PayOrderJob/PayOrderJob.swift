//
//  PayOrderJob.swift
//  
//
//  Created by Artem Mayer on 24.08.2024.
//

import Vapor
import Fluent
import Queues

struct PayOrderJob: AsyncJob {

    typealias Payload = JobData?

    func dequeue(_ context: QueueContext, _ payload: Payload) async throws {

        let db = context.application.db
        guard
            let orderNumber = payload?.orderNumber,
            let order = try await Order.query(on: db).filter(\.$number == orderNumber).first()
        else {
            throw ErrorFactory.badRequest(.orderIdRequired)
        }

        if order.number % 3 == 0, order.paymentType == .card {
            order.paid = true
            try await order.update(on: db)
        }
    }

    func error(_ context: QueueContext, _ error: Error, _ payload: Payload) async throws {}

}
