// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "BlockChypSDK",
    products: [
        .library(name: "BlockChypSDK", targets: ["BlockChypSDK"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BlockChypSDK",
            dependencies: [],
            path: "blockchyp-ios/BlockChyp",
            publicHeadersPath: "."
        )
    ]
)
