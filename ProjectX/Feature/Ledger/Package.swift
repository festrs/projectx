// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ledger",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Ledger",
            targets: ["Ledger"]
        ),
    ],
    dependencies: [
        .package(path: "../Frameworks/Router"),
        .package(path: "../Frameworks/Networking"),
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Ledger",
            dependencies: [
                "Router",
                "Networking",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ],
            resources: [
                .process("Resources/symbols.json")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "LedgerTests",
            dependencies: ["Ledger"]),
    ]
)
