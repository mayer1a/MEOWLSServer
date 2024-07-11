//
//  Configure.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import FluentPostgresDriver
import Vapor

// MARK: - Configure application

struct Configuration {

    public static func configure(_ app: Application) async throws {
        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

        setupLogger(for: app)

        try await connectDatabase(for: app)
        try await setupMigrations(for: app)

        app.routes.defaultMaxBodySize = "500kb"

        try RegisterRoutes.register(for: app)
    }

    private static func connectDatabase(for app: Application) async throws {
        guard
            let hostname = Environment.get("DATABASE_HOST"),
            let username = Environment.get("DATABASE_USERNAME"),
            let password = Environment.get("DATABASE_PASSWORD"),
            let name = Environment.get("DATABASE_NAME")
        else {
            debugPrint("[ERROR] ENVIRONMENTS DOES NOT FOUND")
            throw Abort(.serviceUnavailable)
        }
        
        let sqlConfig = SQLPostgresConfiguration(hostname: hostname,
                                                 port: SQLPostgresConfiguration.ianaPortNumber,
                                                 username: username,
                                                 password: password,
                                                 database: name,
                                                 tls: .disable)

        app.databases.use(.postgres(configuration: sqlConfig), as: .psql, isDefault: true)
    }

    private static func setupLogger(for app: Application) {
        #if DEBUG
            app.logger.logLevel = .debug
        #else
            app.logger.logLevel = .notice
        #endif
    }

    private static func setupMigrations(for app: Application) async throws {
        addUserMigrations(for: app)
        addImageMigrations(for: app)
        addCategoryMigrations(for: app)
        addProductMigrations(for: app)

        try await app.autoMigrate()
    }

    private static func addUserMigrations(for app: Application) {
        app.migrations.add(CreateGender())
        app.migrations.add(CreateUserRole())
        app.migrations.add(CreateUser())
        app.migrations.add(CreateToken())
    }

    private static func addImageMigrations(for app: Application) {
        app.migrations.add(CreateImage())
        app.migrations.add(CreateImageDimension())
    }

    private static func addCategoryMigrations(for app: Application) {
        app.migrations.add(CreateCategory())
    }

    private static func addProductMigrations(for app: Application) {
        app.migrations.add(CreateProduct())
        app.migrations.add(CreateProductProperty())
        app.migrations.add(CreateProductVariant())
        app.migrations.add(CreatePropertyValue())
        app.migrations.add(CreatePrice())
        app.migrations.add(CreateBadge())
        app.migrations.add(CreateAvailabilityType())
        app.migrations.add(CreateAvailabilityInfo())
        app.migrations.add(CreateSectionType())
        app.migrations.add(CreateSection())

        addProductPivotMigrations(for: app)
    }

    private static func addProductPivotMigrations(for app: Application) {
        app.migrations.add(CreateProductImagesPivot())
        app.migrations.add(CreateProductVariantBadgePivot())
    }

    private init() {}

}
