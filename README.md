# JamitFoundation

JamitFoundation is a collection of useful concepts to enable composition oriented development with UIKit

## Installation

### Xcode 11

1. Open your Project and select `File / Swift Packages / Add Package Dependency...`.
2. Enter the Package URL `git@github.com:JamitLabs/JamitFoundation.git` press `Next` and follow the Wizard steps.

### Swift Package Manager

Add the package dependency to your `Package.swift` file.

```swift
 let package = Package(
    // ...
    dependencies: [
+       .package(url: "git@github.com:JamitLabs/JamitFoundation.git", .upToNextMajor(from: "1.0.0"))
    ]
    // ...
 )
```

### Carthage

Add the following line to your Cartfile.

```swift
# A collection of useful concepts to enable composition oriented development with UIKit
git "git@github.com:JamitLabs/JamitFoundation.git"
```

### CocoaPods

Add the following line to your Podfile
```swift
# A collection of useful concepts to enable composition oriented development with UIKit
pod 'JamitFoundation', :tag => '1.3.2', :git => 'https://github.com/JamitLabs/JamitFoundation.git'
```

### Prerequisities
- iOS 10.0 or later
- Swift 5.0 or later

## Usage

Besides the documentation there exists a [sample project](https://github.com/JamitLabs/JamitFoundation/tree/develop/Examples/JamitFoundationExample) which contains a lot of examples to help you out getting started using JamitFoundation.

### Contributing

Great! Look over these things first.
- Please read our [Code of Conduct](https://github.com/JamitLabs/JamitFoundation/blob/develop/CODE_OF_CONDUCT.md)
- Check out the [current issues](https://github.com/JamitLabs/JamitFoundation/issues) and see if you can tackle any of those.
- Download the project and check out the current code base. Suggest any improvements by opening a new issue.
- Be kind and helpful.

### Contact

Have a question or an issue about JamitFoundation? Create an [issue](https://github.com/JamitLabs/JamitFoundation/issues/new)!

### License

JamitFoundation is licensed unter the [MIT License](https://github.com/JamitLabs/JamitFoundation/blob/develop/LICENSE).

## Modules
Following optional modules are available:

- [WeakCache](Modules/WeakCache/README.md)
- PageView
- GridView
- CarouselView
- BarcodeScanner
