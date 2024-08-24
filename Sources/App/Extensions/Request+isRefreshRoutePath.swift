//
//  Request+isRefreshRoutePath.swift
//  
//
//  Created by Artem Mayer on 25.08.2024.
//

import Vapor

extension Request {

    var isRefreshRoutePath: Bool {
        route?.path.contains("refresh_token") ?? false
    }

}
