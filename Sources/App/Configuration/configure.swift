//
//  Configuration.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import FluentPostgresDriver
import Vapor
import Queues
import QueuesFluentDriver

// MARK: - Configure application

struct Configuration {

    public static func configure(_ app: Application) async throws {

        setupLogger(for: app)

        #if DEBUG
            try await loadFromEnvFile(for: app)
        #endif

        try await connectDatabase(for: app)

        #if DEBUG
            try await setupMigrations(for: app)
        #endif

        app.queues.use(.fluent())
        app.queues.configuration.refreshInterval = .minutes(5)
        app.queues.configuration.workerCount = .custom(1)
        app.http.server.configuration.serverName = "MEOWLS"
        
        try await setupScheduledJobs(for: app)

        app.caches.use(.memory)
        app.routes.defaultMaxBodySize = "500kb"

        try RegisterRoutes.register(for: app)
    }

    private static func connectDatabase(for app: Application) async throws {

        guard
            let hostname = Environment.get("DATABASE_HOST"),
            let username = Environment.get("DATABASE_USERNAME"),
            let password = Environment.get("DATABASE_PASSWORD"),
            let name = Environment.get("DATABASE_NAME"),
            let daDataToken = Environment.get("DADATA_TOKEN")
        else {
            throw ErrorFactory.serviceUnavailable(failures: [.environments])
        }

        AppConstants.shared.daDataToken = daDataToken

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

    private static func setupScheduledJobs(for app: Application) async throws {
        app.queues.schedule(CompletePaidOrdersJob())
            .hourly()
            .at(1)

        app.queues.add(PayOrderJob())

        try app.queues.startInProcessJobs()
        try app.queues.startScheduledJobs()
    }

    private static func setupMigrations(for app: Application) async throws {

        addUserMigrations(for: app)
        addImageMigrations(for: app)
        addCategoryMigrations(for: app)
        addProductMigrations(for: app)
        addMainBannerMigrations(for: app)
        addSalesMigrations(for: app)
        addFavoritesMigrations(for: app)
        addPromoCodesMigrations(for: app)
        addCartMigrations(for: app)
        addDeliveryMigrations(for: app)
        app.migrations.add(JobMetadataMigrate())

        try await app.autoMigrate()
    }

    private static func addUserMigrations(for app: Application) {

        app.migrations.add(CreateGender())
        app.migrations.add(CreateUserRole())
        app.migrations.add(CreateUser())
        app.migrations.add(CreateToken())
    }

    private static func addCategoryMigrations(for app: Application) {

        app.migrations.add(CreateCategory())
    }

    private static func addImageMigrations(for app: Application) {

        app.migrations.add(CreateImage())
        app.migrations.add(CreateImageDimension())
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
        app.migrations.add(CreateProductVariantsPropertyValuesPivot())
        app.migrations.add(CreateCategoriesProductsPivot())
    }

    private static func addMainBannerMigrations(for app: Application) {

        app.migrations.add(CreateMainBannerPlaceType())
        app.migrations.add(CreateRedirectRedirectType())
        app.migrations.add(CreateMainBanner())
        app.migrations.add(CreateMainBannerRedirect())
        app.migrations.add(CreateMainBannerUISettings())
        app.migrations.add(CreateRedirectProductsSet())
        app.migrations.add(CreateUISettingsCornerRadius())
        app.migrations.add(CreateUISettingsMetric())
        app.migrations.add(CreateUISettingsSpacing())
        app.migrations.add(CreateRedirectObjectType())
    }

    private static func addSalesMigrations(for app: Application) {

        app.migrations.add(CreateSaleType())
        app.migrations.add(CreateSale())
    }

    private static func addFavoritesMigrations(for app: Application) {

        app.migrations.add(CreateFavorites())
        app.migrations.add(CreateFavoritesProductsPivot())
    }

    private static func addPromoCodesMigrations(for app: Application) {

        app.migrations.add(CreateDiscountType())
        app.migrations.add(CreatePromoCode())
        app.migrations.add(CreatePromoCodesProductsPivot())
        app.migrations.add(CreatePromoCodesUsersPivot())
    }

    private static func addCartMigrations(for app: Application) {

        app.migrations.add(CreateCart())

        addOrderMigrations(for: app)
        
        app.migrations.add(CreateCartItem())
        app.migrations.add(CreateSummary())
        app.migrations.add(CreateSummaryType())
        app.migrations.add(CreateCartsPromoCodesPivot())
    }

    private static func addOrderMigrations(for app: Application) {
        
        app.migrations.add(CreateStatusCode())
        app.migrations.add(CreatePaymentType())
        
        app.migrations.add(CreateOrder())
    }

    private static func addDeliveryMigrations(for app: Application) {
        
        app.migrations.add(CreateDeliveryType())
        app.migrations.add(CreateDelivery())
        app.migrations.add(CreateAddress())
        app.migrations.add(CreateRegion())
        app.migrations.add(CreateCity())
        app.migrations.add(CreateDeliveryTimeInterval())
        app.migrations.add(CreateLocation())
    }

    #if DEBUG 

    private static func loadFromEnvFile(for app: Application) async throws {

        let packageRootPath = URL(fileURLWithPath: #file).pathComponents
            .prefix(while: { $0 != "Sources" })
            .joined(separator: "/")
            .dropFirst()
            .appending("/.env")

        try await DotEnvFile.read(path: packageRootPath, fileio: app.fileio).load(overwrite: true)
    }

    #endif

    private init() {}

}
