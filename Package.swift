// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NiceArchitecture",
    platforms: [
        .iOS("15.0"),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "NiceArchitecture", targets: ["NiceArchitecture"]),
    ],
    dependencies: [
        .package(url: "https://github.com/steamclock/steamclog-swift.git", from: "2.3.1")
    ],
    targets: [
        .target(
            name: "NiceArchitecture",
            dependencies: [
                .product(name: "SteamcLog", package: "steamclog-swift")
            ]
        ),
    ]
)
