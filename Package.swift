// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "JamitFoundation",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "JamitFoundation", targets: ["JamitFoundation"]),
        .library(name: "PageView", targets: ["PageView"]),
        .library(name: "GridView", targets: ["GridView"]),
        .library(name: "BarcodeScanner", targets: ["BarcodeScanner"]),
        .library(name: "CarouselView", targets: ["CarouselView"]),
        .library(name: "WeakCache", targets: ["WeakCache"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "JamitFoundation",
            dependencies: [],
            path: "Sources"
        ),
        .target(
            name: "PageView",
            dependencies: ["JamitFoundation"],
            path: "Modules/PageView"
        ),
        .target(
            name: "GridView",
            dependencies: ["JamitFoundation"],
            path: "Modules/GridView"
        ),
        .target(
            name: "BarcodeScanner",
            dependencies: ["JamitFoundation"],
            path: "Modules/BarcodeScanner"
        ),
        .target(
            name: "CarouselView",
            dependencies: ["JamitFoundation"],
            path: "Modules/CarouselView"
        ),
        .target(
            name: "WeakCache",
            dependencies: ["JamitFoundation"],
            path: "Modules/WeakCache"
        )
    ]
)

