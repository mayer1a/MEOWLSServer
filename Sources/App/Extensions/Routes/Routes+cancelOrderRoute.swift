//
//  Routes+cancelOrderRoute.swift
//  
//
//  Created by Artem Mayer on 24.08.2024.
//

import Vapor

extension Routes {

    var cancelOrderRoute: Route? {
        all.first(where: { $0.description.contains("/api/v1/orders/:order_number/cancel") })
    }

}
