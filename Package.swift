// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Iconic",
    targets: [
        Target(
            name: "Iconic",
            dependencies: ["IconicKit"]
        ),
        Target(name: "IconicKit")
    ],
    dependencies: [
        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/kylef/Stencil.git", majorVersion: 0, minor: 9),
        .Package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", majorVersion: 1, minor: 0)
    ]
)
