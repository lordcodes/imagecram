// swift-tools-version:5.1

// Copyright (C) 2020 Andrew Lord

import PackageDescription

let package = Package(
    name: "ImageCram",
    products: [
        .library(name: "ImageCram", targets: ["ImageCram"]),
        .executable(name: "imagecram-cli", targets: ["ImageCramCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0")
    ],
    targets: [
        .target(name: "ImageCram"),
        .target(name: "ImageCramCLI", dependencies: ["ImageCram", "ArgumentParser", "Files"]),
        .testTarget(name: "ImageCramTests", dependencies: ["ImageCram"])
    ]
)
