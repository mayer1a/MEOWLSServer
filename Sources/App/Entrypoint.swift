//
//  Entrypoint.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Vapor
import Logging

@main
enum Entrypoint {

    static func main() async throws {

        var env = try Environment.detect()

        try LoggingSystem.bootstrap(from: &env)

        let app = try await Application.make(env)
        app.middleware.use(CustomErrorMiddleware())

        do {

            try await Configuration.configure(app)
        } catch {

            app.logger.report(error: error)
            try? await app.asyncShutdown()
            throw error
        }
        
        try await app.execute()
        try await app.asyncShutdown()
    }

}
