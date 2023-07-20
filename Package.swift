// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NiceUtilities",
    platforms: [
        .iOS("15.0"),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "NiceUtilities", targets: ["NiceUtilities"]),
    ],
    dependencies: [
        .package(url: "https://github.com/steamclock/nice_components.git", branch: "main"),
        .package(url: "https://github.com/steamclock/steamclog-swift.git", branch: "master"),
        .package(url: "https://github.com/steamclock/netable.git", branch: "master")
    ],
    targets: [
        .target(
            name: "NiceUtilities",
            dependencies: [
                .product(name: "Netable", package: "netable"),
                .product(name: "NiceComponents", package: "nice_components"),
                .product(name: "SteamcLog", package: "steamclog-swift")
            ]
        ),
    ]
)
