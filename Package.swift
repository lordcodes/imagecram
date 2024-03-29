// swift-tools-version:5.1

// Copyright (C) 2020 Andrew Lord

import PackageDescription

let package = Package(
    name: "ImageCram",
    products: [
        .library(name: "ImageCram", targets: ["ImageCram"]),
        .executable(name: "imagecram-cli", targets: ["ImageCramCLI"]),
        .executable(name: "task", targets: ["ImageCramTasks"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.39.1"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.44.4"),
        .package(url: "https://github.com/JohnSundell/ShellOut", from: "2.3.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
    ],
    targets: [
        .target(name: "ImageCram", dependencies: ["Files"]),
        .target(name: "ImageCramCLI", dependencies: ["ImageCram", "ArgumentParser", "Files"]),
        .target(name: "ImageCramTasks", dependencies: ["ArgumentParser", "ShellOut"]),
        .testTarget(name: "ImageCramTests", dependencies: ["ImageCram", "Files"]),
    ]
)
