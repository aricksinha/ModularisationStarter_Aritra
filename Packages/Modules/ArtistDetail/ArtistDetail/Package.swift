// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let analyticsInterface = "AnalyticsInterface"
private let commonModels = "CommonModels"
private let container = "Container"
private let utilities = "Utilities"
private let artistDetailPlugin = "ArtistDetailPluginAPI"
private let temporaryMainPackage = "TemporaryMainPackage"

let package = Package(
    name: "ArtistDetail",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ArtistDetail",
            targets: ["ArtistDetail"]),
    ],
    // adding all imported dependencies in this module
    dependencies: [
        .package(name: analyticsInterface, path: "../../../Analytics/\(analyticsInterface)"),
        .package(name: commonModels, path: "../../../\(commonModels)"),
        .package(name: container, path: "../../../\(container)"),
        .package(name: utilities, path: "../../../\(utilities)"),
        .package(name: artistDetailPlugin, path: "../../\(artistDetailPlugin)"),
        .package(name: temporaryMainPackage, path: "../../../\(temporaryMainPackage)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ArtistDetail",
            dependencies: [
                .product(name: analyticsInterface, package: analyticsInterface),
                .product(name: commonModels, package: commonModels),
                .product(name: container, package: container),
                .product(name: utilities, package: utilities),
                .product(name: artistDetailPlugin, package: artistDetailPlugin),
                .product(name: temporaryMainPackage, package: temporaryMainPackage)
            ]
        ),
        .testTarget(
            name: "ArtistDetailTests",
            dependencies: ["ArtistDetail"]),
    ]
)
