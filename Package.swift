// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SungrowKit",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SungrowKit",
            targets: ["SungrowKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/DimaRU/SwiftyModbus.git", from: "2.2.1")
    ],
    targets: [
        .target(
            name: "SungrowKit",
            dependencies: [
                .product(name: "SwiftyModbus", package: "SwiftyModbus")
            ]
        ),
        .testTarget(
            name: "SungrowKitTests",
            dependencies: ["SungrowKit"]
        )
    ]
)
