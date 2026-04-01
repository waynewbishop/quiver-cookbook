// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "quiver-cookbook",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/waynewbishop/quiver.git", from: "1.0.1")
    ],
    targets: [
        .target(
            name: "Recipes",
            dependencies: [
                .product(name: "Quiver", package: "quiver")
            ]
        )
    ]
)
