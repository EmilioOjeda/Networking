// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    products: [
        .library(
            name: "Url",
            targets: ["Url"]
        ),
        .library(
            name: "Request",
            targets: ["Request"]
        )
    ],
    targets: [
        .target(
            name: "Url"
        ),
        .testTarget(
            name: "UrlTests",
            dependencies: ["Url"]
        ),
        .target(
            name: "Request",
            dependencies: ["Url"]
        ),
        .testTarget(
            name: "RequestTests",
            dependencies: ["Request", "Url"]
        )
    ],
    swiftLanguageModes: [.v6]
)
