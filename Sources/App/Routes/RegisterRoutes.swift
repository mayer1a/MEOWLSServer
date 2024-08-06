//
//  RegisterRoutes.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import Vapor

struct RegisterRoutes {

    static func register(for app: Application) throws {

        // For render.com
        app.get("health-check") { _ async throws in DummyResponse() }


        app.routes.print()
    }

    private init() {}

}
