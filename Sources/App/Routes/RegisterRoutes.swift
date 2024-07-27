//
//  RegisterRoutes.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import Vapor

// MARK: - Functions

struct RegisterRoutes {

    static func register(for app: Application) throws {

        // For render.com
        app.get("health-check") { _ async throws in DummyResponse() }

        try app.register(collection: CatalogController())
        try app.register(collection: UserController())

        app.routes.print()
    }

    private init() {}

}
