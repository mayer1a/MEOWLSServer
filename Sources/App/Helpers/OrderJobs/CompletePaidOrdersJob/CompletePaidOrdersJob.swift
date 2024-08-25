//
//  CompletePaidOrdersJob.swift
//
//
//  Created by Artem Mayer on 24.08.2024.
//

import Vapor
import Fluent
import Queues

struct CompletePaidOrdersJob: AsyncScheduledJob {

    func run(context: QueueContext) async throws {

        try await context.application.db.transaction { transaction in

            try await Order.query(on: transaction)
                .filter(\.$statusCode != .canceled)
                .with(\.$delivery)
                .with(\.$user, { $0.with(\.$token) })
                .all()
                .asyncForEach { order in

                    let now = Date.now
                    let deliveryDate = order.delivery?.deliveryDate ?? now

                    if order.statusCode == .inProgress, order.paid == true, now > deliveryDate {

                        order.statusCode = .completed
                        order.status = order.statusCode.getStatus()
                        try await order.update(on: transaction)

                    } else if order.statusCode == .inProgress, now > deliveryDate {

                        try await revertItemsQuantity(for: order, app: context.application, in: transaction)
                    }
                }
        }
    }

    private func revertItemsQuantity(for order: Order, app: Application, in db: Database) async throws {

        guard
            let cancelOrderRoute = app.routes.cancelOrderRoute?.path.string,
            let tokenValue = order.user.token?.tokenFormatValue
        else {
            return
        }
        let host = app.http.server.configuration.hostname
        let port = app.http.server.configuration.port
        let endpoint = cancelOrderRoute.replacing(":order_number", with: "\(order.number)")
        let uri = URI(string: "http://\(host):\(port)/\(endpoint)")

        _ = try await app.client.post(uri) { request in
            request.headers.replaceOrAdd(name: .authorization, value: tokenValue)
        }
    }

}
