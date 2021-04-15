// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "JamitFoundation",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "JamitFoundation", targets: ["JamitFoundation"]),
        .library(name: "PageView", targets: ["PageView"]),
        .library(name: "GridView", targets: ["GridView"]),
        .library(name: "BarcodeScanner", targets: ["BarcodeScanner"]),
        .library(name: "CarouselView", targets: ["CarouselView"]),
        .library(name: "TimePickerView", targets: ["TimePickerView"]),
        .library(name: "WeakCache", targets: ["WeakCache"]),
        .library(name: "UserDefaults", targets: ["UserDefaults"]),
        .library(name: "Keychain", targets: ["Keychain"]),
        .library(name: "MessageView", targets: ["MessageView"])
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
            name: "WeakCacheTests",
            dependencies: ["WeakCache"],
            path: "Modules/WeakCache/Tests"
        ),
        .target(
            name: "UserDefaults",
            dependencies: ["JamitFoundation"],
            path: "Modules/UserDefaults/Sources"
        ),
        .testTarget(
            name: "UserDefaultsTests",
            dependencies: ["UserDefaults"],
            path: "Modules/UserDefaults/Tests"
        ),
        .target(
            name: "Keychain",
            dependencies: ["JamitFoundation"],
            path: "Modules/Keychain/Sources"
        ),
        .testTarget(
            name: "KeychainTests",
            dependencies: ["Keychain"],
            path: "Modules/Keychain/Tests"
        ),
        .target(
            name: "MessageView",
            dependencies: ["JamitFoundation"],
            path: "Modules/MessageView"
        )
    ]
)
