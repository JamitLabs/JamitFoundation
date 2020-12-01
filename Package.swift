// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "JamitFoundation",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "JamitFoundation", targets: ["JamitFoundation"]),
        .library(name: "PageView", targets: ["PageView"]),
        .library(name: "GridView", targets: ["GridView"]),
        .library(name: "BarcodeScanner", targets: ["BarcodeScanner"]),
        .library(name: "CarouselView", targets: ["CarouselView"]),
        .library(name: "TimePickerView", targets: ["TimePickerView"]),
        .library(name: "WeakCache", targets: ["WeakCache"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.8.1"
        ),
    ],
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
            dependencies: ["JamitFoundation", "SnapshotTesting"],
            path: "Modules/BarcodeScanner"
        ),
        .target(
            name: "CarouselView",
            dependencies: ["JamitFoundation"],
            path: "Modules/CarouselView"
        ),
        .target(
            name: "TimePickerView",
            dependencies: ["JamitFoundation"],
            path: "Modules/TimePickerView"
		),
		.target(
            name: "WeakCache",
            dependencies: ["JamitFoundation"],
            path: "Modules/WeakCache/Sources"
        ),
        .testTarget(
            name: "JamitFoundationTests",
            dependencies: ["JamitFoundation", "SnapshotTesting"],
            path: "Tests/JamitFoundation"
        ),
        .testTarget(
            name: "PageViewTests",
            dependencies: ["JamitFoundation"],
            path: "Tests/Modules/PageView"
        ),
        .testTarget(
            name: "GridViewTests",
            dependencies: ["JamitFoundation"],
            path: "Tests/Modules/GridView"
        ),
        .testTarget(
            name: "BarcodeScannerTests",
            dependencies: ["JamitFoundation", "BarcodeScanner"],
            path: "Tests/Modules/BarcodeScanner"
        ),
        .testTarget(
            name: "CarouselViewTests",
            dependencies: ["JamitFoundation"],
            path: "Tests/Modules/CarouselView"
        ),
        .testTarget(
            name: "TimePickerViewTests",
            dependencies: ["JamitFoundation"],
            path: "Tests/Modules/TimePickerView"
        ),
        .testTarget(
            name: "WeakCacheTests",
            dependencies: ["WeakCache"],
            path: "Tests/Modules/WeakCache"
        ),
    ]
)
