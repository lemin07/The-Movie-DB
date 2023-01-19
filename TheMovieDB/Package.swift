// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheMovieDB",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Shared", targets: ["Shared"]),
        .library(name: "UI", targets: ["UI"]),
        .library(name: "Network", targets: ["Network"]),
        .library(name: "Networking", targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "14.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Network",
            dependencies: [
            ]
        ),
        
            .target(
                name: "Shared",
                dependencies: [
                    .product(name: "KeychainSwift", package: "keychain-swift"),
                ]
            ),
        
            .target(
                name: "KeychainStorage",
                dependencies: [
                    "Shared",
                ]
            ),
        
            .target(
                name: "Networking",
                dependencies: [
                    "Network",
                ]
            ),
        
            .target(
                name: "UI",
                dependencies: [
                    "Shared",
                    "Network",
                ],
                resources: [
                    .process("Resources"),
                ]
            ),
        
            .target(
                name: "AppFeature",
                dependencies: [
                    "Shared",
                    "UI",
                    "KeychainStorage",
                    "Network",
                    "Networking",
                ]),
        
    ]
)
