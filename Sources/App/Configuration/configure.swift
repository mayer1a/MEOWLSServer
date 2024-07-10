import Fluent
import FluentPostgresDriver
import Vapor

// MARK: - Configures your application

public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    guard
        let hostname = Environment.get("DATABASE_HOST"),
        let username = Environment.get("DATABASE_USERNAME"),
        let password = Environment.get("DATABASE_PASSWORD"),
        let name = Environment.get("DATABASE_NAME")
    else {
        debugPrint("[ERROR] ENVIRONMENTS DOES NOT UNWRAP")
        throw Abort(.serviceUnavailable)
    }

    let sqlConfig = SQLPostgresConfiguration(hostname: hostname,
                                             port: SQLPostgresConfiguration.ianaPortNumber,
                                             username: username,
                                             password: password,
                                             database: name,
                                             tls: .disable)
    /*.prefer(try .init(configuration: .clientDefault))*/
    app.databases.use(.postgres(configuration: sqlConfig), as: .psql, isDefault: true)

    addMigrations(for: app)

    app.logger.logLevel = .debug

    try await app.autoMigrate()

    app.routes.defaultMaxBodySize = "500kb"
    
    // Register routes
    try registerRoutes(for: app)
}

private func addMigrations(for app: Application) {
    app.migrations.add(CreateTodo())
    app.migrations.add(CreateGenderMigration())
    app.migrations.add(CreateUserMigration())
    app.migrations.add(TokenMigration())
}
