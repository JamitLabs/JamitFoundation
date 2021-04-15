# JamitFoundation

JamitFoundation is a collection of useful concepts to enable composition oriented development with UIKit

## Installation

### Xcode 11

1. Open your Project and select `File / Swift Packages / Add Package Dependency...`.
2. Enter the Package URL `https://github.com/JamitLabs/JamitFoundation.git` press `Next` and follow the Wizard steps.

### Swift Package Manager

Add the package dependency to your `Package.swift` file.

```swift
 let package = Package(
    // ...
    dependencies: [
+       .package(url: "https://github.com/JamitLabs/JamitFoundation.git", .upToNextMajor(from: "1.5.0"))
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

Add the following line to your Podfile.

```swift
pod 'JamitFoundation', :git => 'https://github.com/JamitLabs/JamitFoundation.git', :tag => '1.5.0', :inhibit_warnings => true
```

If you don't want to include all of JamitFoundation, but only specific microframeworks (e.g. PageView), add the following line to your Podfile.

```swift
pod 'JamitFoundation/PageView', :git => 'https://github.com/JamitLabs/JamitFoundation.git', :tag => '1.5.0', :inhibit_warnings => true
```

## Usage

### View / ViewController usage concept

#### Instantiation

Views and ViewControllers should be instantiated using the `instantiate(bundle:, withOwner:, options:)` extension on UIView and UIViewController, it will lookup for a nib file with the same name as the custom view class in the bundle and instantiate it or if there is no nib available the default initializer will be used for instantiation.

#### Specializations

Every view with dynamic content should subclass from `StatefulView` with a specific `ViewModel`.

Example:

```swift
final class ExampleView: StatefulView<ExampleViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load custom child views here or run initial setup code ...
    }

    override func didChangeModel() {
        super.didChangeModel()

        // Update view content using model here ...
        print(model.title)
    }
}

struct ExampleViewModel: ViewModelProtocol {
    let title: String

    init(
        title: String = ExampleViewModel.default.title
    ) {
        self.title = title
    }
}

extension ExampleViewModel {
    static let `default`: ExampleViewModel = .init(
        title: ""
    )
}

```

#### TableView / CollectionView usage

Every `StatefulView` can also be used inside a UITableView or in a UICollectionView as cell by creating a cell specialization.

Example:

```swift
final class ExampleTableViewCell: ContainerTableViewCell<ExampleView> {}

final class ExampleCollectionViewCell: ContainerCollectionViewCell<ExampleView> {}

final class MyTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellOfType: ExampleTableViewCell.self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellOfType: ExampleTableViewCell.self, for: indexPath)
        cell.model = ExampleViewModel(title: "Hello World")
        return cell
    }
}
```

## Modules
Following optional modules are available:

- [WeakCache](Modules/WeakCache/README.md)
- PageView
- GridView
- CarouselView
- BarcodeScanner
- TimePickerView
- MessageView
