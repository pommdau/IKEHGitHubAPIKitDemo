// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DangerDepsProduct",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "DangerDepsProduct",
            type: .dynamic,
            targets: ["DangerDepsProduct"]),
    ],
    dependencies: [
        .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "3.14.2"),
    ],
    targets: [
        .target(
            name: "DangerDepsProduct",
            dependencies: [
                .product(name: "Danger", package: "danger-swift"),
            ]),
        .testTarget(
            name: "DangerDepsProductTests",
            dependencies: ["DangerDepsProduct"]),
    ]
)
