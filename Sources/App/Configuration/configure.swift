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

        configureQueues(for: app)
        
        try await setupScheduledJobs(for: app)

        app.http.server.configuration.serverName = "MEOWLS"
        app.caches.use(.memory)
        app.routes.defaultMaxBodySize = "500kb"

        try RegisterRoutes.register(for: app)
    }

    private static func setupLogger(for app: Application) {
        #if DEBUG
            app.logger.logLevel = .debug
        #else
            app.logger.logLevel = .notice
        #endif
    }

    #if DEBUG

    private static func loadFromEnvFile(for app: Application) async throws {

        let fileName: String
        switch app.environment {
        case .production: fileName = ".env.production"
        case .development: fileName = ".env.development"
        default: fileName = ".env.testing"
        }

        app.logger.info("1908: FILENAME \(fileName)")
        print("1908: FILENAME \(fileName)")

        let packageRootPath = URL(fileURLWithPath: #file).pathComponents
            .prefix(while: { $0 != "Sources" })
            .joined(separator: "/")
            .dropFirst()
            .appending("/.env")

        try await DotEnvFile.read(path: packageRootPath, fileio: app.fileio).load(overwrite: true)
    }

    #endif

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
        app.migrations.add([CreateGender(), CreateUserRole(), CreateUser(), CreateToken()])
    }

    private static func addCategoryMigrations(for app: Application) {
        app.migrations.add(CreateCategory())
    }

    private static func addImageMigrations(for app: Application) {
        app.migrations.add([CreateImage(), CreateImageDimension()])
    }

    private static func addProductMigrations(for app: Application) {
        app.migrations.add([CreateProduct(),
                            CreateProductProperty(),
                            CreateProductVariant(),
                            CreatePropertyValue(),
                            CreatePrice(),
                            CreateBadge(),
                            CreateAvailabilityType(),
                            CreateAvailabilityInfo(),
                            CreateSectionType(),
                            CreateSection()])

        addProductPivotMigrations(for: app)
    }

    private static func addProductPivotMigrations(for app: Application) {
        app.migrations.add([CreateProductImagesPivot(),
                            CreateProductVariantBadgePivot(),
                            CreateProductVariantsPropertyValuesPivot(),
                            CreateCategoriesProductsPivot()])
    }

    private static func addMainBannerMigrations(for app: Application) {
        app.migrations.add([CreateMainBannerPlaceType(),
                            CreateRedirectRedirectType(),
                            CreateMainBanner(),
                            CreateMainBannerRedirect(),
                            CreateMainBannerUISettings(),
                            CreateRedirectProductsSet(),
                            CreateUISettingsCornerRadius(),
                            CreateUISettingsMetric(),
                            CreateUISettingsSpacing(),
                            CreateRedirectObjectType()])
    }

    private static func addSalesMigrations(for app: Application) {
        app.migrations.add([CreateSaleType(), CreateSale()])
    }

    private static func addFavoritesMigrations(for app: Application) {
        app.migrations.add([CreateFavorites(), CreateFavoritesProductsPivot()])
    }

    private static func addPromoCodesMigrations(for app: Application) {
        app.migrations.add([CreateDiscountType(),
                            CreatePromoCode(),
                            CreatePromoCodesProductsPivot(),
                            CreatePromoCodesUsersPivot()])
    }

    private static func addCartMigrations(for app: Application) {
        app.migrations.add(CreateCart())

        addOrderMigrations(for: app)
        
        app.migrations.add([CreateCartItem(), CreateSummary(), CreateSummaryType(), CreateCartsPromoCodesPivot()])
    }

    private static func addOrderMigrations(for app: Application) {
        app.migrations.add([CreateStatusCode(), CreatePaymentType(), CreateOrder()])
    }

    private static func addDeliveryMigrations(for app: Application) {
        app.migrations.add([CreateDeliveryType(),
                            CreateDelivery(),
                            CreateAddress(),
                            CreateRegion(),
                            CreateCity(),
                            CreateDeliveryTimeInterval(),
                            CreateLocation()])
    }

    private static func configureQueues(for app: Application) {
        app.queues.use(.fluent())
        app.queues.configuration.refreshInterval = .minutes(5)
        app.queues.configuration.workerCount = .custom(1)
    }

    private static func setupScheduledJobs(for app: Application) async throws {
        app.queues.schedule(CompletePaidOrdersJob())
            .hourly()
            .at(1)

        app.queues.add(PayOrderJob())

        try app.queues.startInProcessJobs()
        try app.queues.startScheduledJobs()
    }

    private init() {}

}
