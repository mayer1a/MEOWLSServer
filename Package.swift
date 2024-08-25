// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MEOWLSServer",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.101.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.11.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.9.0"),
        .package(url: "https://github.com/m-barthelemy/vapor-queues-fluent-driver.git", from: "3.0.0-beta1")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "QueuesFluentDriver", package: "vapor-queues-fluent-driver")
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
            .product(name: "Vapor", package: "vapor")
        ],
        swiftSettings: swiftSettings)
    ]
)

var swiftSettings: [SwiftSetting] {
    [.enableUpcomingFeature("DisableOutwardActorInference")]
}
