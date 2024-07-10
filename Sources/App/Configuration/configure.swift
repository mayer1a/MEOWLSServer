//
//  Configure.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import FluentPostgresDriver
import Vapor

// MARK: - Configures application

public func configure(_ app: Application) async throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    setupLogger(for: app)

    try await connectDatabase(for: app)
    try await setupMigrations(for: app)

    app.routes.defaultMaxBodySize = "500kb"

    try registerRoutes(for: app)
}

private func connectDatabase(for app: Application) async throws {
    guard
        let hostname = Environment.get("DATABASE_HOST"),
        let username = Environment.get("DATABASE_USERNAME"),
        let password = Environment.get("DATABASE_PASSWORD"),
        let name = Environment.get("DATABASE_NAME")
    else {
        debugPrint("[ERROR] ENVIRONMENTS DOES NOT FOUND")
        throw Abort(.serviceUnavailable)
    }
    print("\n\n------------------------------------------------------------------------------")
    print("[DATABASE_HOST]: \(hostname)")
    print("[DATABASE_USERNAME]: \(username)")
    print("[DATABASE_PASSWORD]: \(password)")
    print("[DATABASE_NAME]: \(name)")
    print("------------------------------------------------------------------------------\n\n")
    let sqlConfig = SQLPostgresConfiguration(hostname: hostname,
                                             port: SQLPostgresConfiguration.ianaPortNumber,
                                             username: username,
                                             password: password,
                                             database: name,
                                             tls: .disable)

    app.databases.use(.postgres(configuration: sqlConfig), as: .psql, isDefault: true)
}

private func setupLogger(for app: Application) {
    #if DEBUG
        app.logger.logLevel = .debug
    #else
        app.logger.logLevel = .notice
    #endif
}

private func setupMigrations(for app: Application) async throws {
    app.migrations.add(GenderMigration())
    app.migrations.add(UserRoleMigration())
    app.migrations.add(UserMigration())
    app.migrations.add(TokenMigration())

    try await app.autoMigrate()
}
