# JamitFoundation

![Swift](https://img.shields.io/badge/Swift-5.0-orange)
![Version](https://img.shields.io/github/v/tag/JamitLabs/JamitFoundation?label=Version)
![Platforms](https://img.shields.io/badge/Platforms-iOS-yellow)
![License](https://img.shields.io/github/license/JamitLabs/JamitFoundation)
![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen)

JamitFoundation is a lightweight collection of useful concepts to enable data and composition oriented development with UIKit.

## Table Of Contents

1. [Motivation](#motivation)
2. [Features](#features)
3. [Installation](#installation)
    - [Xcode](#xcode)
    - [Swift Package Manager](#swiftpackagemanager)
    - [Carthage](#carthage)
    - [CocoaPods](#cocoapods)
4. [Documentation](#documentation)
    - [Basics](#basics)
    - [Modules](#modules)
5. [Contributing](#contributing)
6. [License](#license)


## Motivation

As an agency working on many different projects with Swift and UIKit brings up new challenges to deliver high quality solutions in reasonable time. It is important to maintain a common sense of code styles and app structure in the development team, but yet it is difficult to merge the collection of knowledge together when the team is split into smaller project groups working on very different topics. JamitFoundation was designed to merge the team knowledge into a reusable core framework which is used in all applications we deliver. It defines a lightweight protocol oriented concept and structure to write maintainable and reusable user interfaces with UIKit on iOS platforms. All general purpose solutions are combined together in modules and reusable views to improve quality over time and to stop reinventing the wheel. By sharing the framework with the open source community we invite you all to benefit from the usage and share your knowledge with others by contributing to the project.

## Features

- Lightweight zero dependency based core framework
- Data oriented and declarative view creation and usage
- Reusable UIKit components
- Code sharing in views and tableview / collectionview cells
- Inheritance based view behaviour composition
- Rich core features and optional plugin modules

## Installation

### Xcode

1. Open your project and select `File / Swift Packages / Add Package Dependency...`.
2. Enter the package URL `https://github.com/JamitLabs/JamitFoundation.git` press `Next` and follow the wizard steps.

### Swift Package Manager

Add the package dependency to your `Package.swift` file.

```swift
 let package = Package(
    // ...
    dependencies: [
+       .package(url: "https://github.com/JamitLabs/JamitFoundation.git", .upToNextMajor(from: "1.5.2"))
    ]
    // ...
 )
```

### Carthage

Add the following line to your Cartfile.

```swift
# A lightweight collection of useful concepts to enable data and composition oriented development with UIKit.
git "git@github.com:JamitLabs/JamitFoundation.git"
```

### CocoaPods

Add the following line to your Podfile.

```swift
pod 'JamitFoundation', :git => 'https://github.com/JamitLabs/JamitFoundation.git', :tag => '1.5.2', :inhibit_warnings => true
```

If you don't want to include all of JamitFoundation, but only specific microframeworks (e.g. PageView), add the following line to your Podfile.

```swift
pod 'JamitFoundation/PageView', :git => 'https://github.com/JamitLabs/JamitFoundation.git', :tag => '1.5.2', :inhibit_warnings => true
```

## Documentation

### Basics

1. [View Instantiation](#viewinstantiation)
2. [StatefulView](#statefulview)
3. [StatefulViewController](#statefulviewcontroller)
4. [Cells](#cells)
    - [Code Sharing](#codesharing)
    - [Registration](#registration)
    - [Dequeue](#dequeue)

#### View Instantiation

Every view is instantiated by using the extension function `instantiate(bundle:owner:options:)`. This function will automatically check if a `nib` file with the same name as the view `class` exists and will load it from the `nib` file else it will initialize it as usual. By using `xib` files we can reduce the code size dramatically and also create layouts with visual feedback in Xcode.  

Example:

```swift
// If a nib file with the name `MyView` exists then it will be instantiated,
// else the default initializer of `UIView` will be used.

// `-instantiate` returns an instance of type `MyView` by inferring the type.
let myView: MyView = .instantiate()

// `-instantiate` returns an instance of type `MyOtherView`.
let mySecondView = MyOtherView.instantiate()
```

#### StatefulView

The StatefulView is the base view which contains a generic mutable state of type `Model`. The model contains all semantical data informations required to present the view. Every subclass of the `StatefulView` is intended to have a mutable state and should only be configured by assigning it's `Model`. Subviews inside a `StatefulView` should always be private and not accessible from outside. Callbacks should also be passed as closures inside the `Model` so that no methods of the view are called from outside. If a custom view is not ment to be subclassed we always define it as `final` and only leave it `open` if it is used to compose behaviour into other view classes by using generic parameters. 

Example:

```swift

import JamitFoundation

struct MyCustomContentViewModel: ViewModelProtocol {
    let title: String

    init(title: String = Self.default.title) {
        self.title = title
    }
}

extension MyCustomContentViewModel {
    static let `default`: Self = .init(title: "")
}

final class MyCustomContentView: StatefulView<MyCustomContentViewModel> {
    private lazy var titleLabel: Label = .instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform view and layout setup logic here...

        addSubview(titleLabel)
    }

    override func didChangeModel() {
        super.didChangeModel()
        
        // Perform view updates based on model data here...

        titleLabel.text = model.title
    }
}
```

#### StatefulViewController

The `StatefulViewController` has the same concept like [StatefulView](#statefulview) with the difference that it derives from `UIViewController` instead of `UIView`.

Example:

```swift

import CarouselView
import JamitFoundation
import UIKit

struct CarouselViewControllerModel: ViewModelProtocol {
    let title: String
    let content: CarouselViewModel

    init(
        title: String = Self.default.title,
        content: CarouselViewModel = self.default.content
    ) {
        self.title = title
        self.content = content
    }
}

extension CarouselViewControllerModel {
    static var `default`: Self = .init(title: "", content: .default)
}

final class CarouselViewController: StatefulViewController<CarouselViewControllerModel> {
    private lazy var carouselView: CarouselView<CarouselItemView> = .instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()

        carouselView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carouselView)
        carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        carouselView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        title = model.title
        carouselView.model = model.content
    }
}
```

#### Cells

##### Code Sharing

Sharing the code between stateful views and table/collection view cells is straight forward by using the `ContainerTableViewCell` or `ContainerCollectionViewCell` which encapsulate a statefulview into a `TableViewCell` or `CollectionViewCell`.

Example:

```swift

// Only the inheritance is enough to make use of stateful views inside of table views!
final class MyCustomContentTableViewCell: ContainerTableViewCell<MyCustomContentView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform additional cell initialization code additional to MyCustomContentView logic
    }
        
    // It is still possible to make customizations to the behaviour of the cell by overriding its methods
    override func prepareForReuse() {
        super.prepareForReuse()

        // So additional cleanup on reuse...
    }
}

// Same is possible with collection view cells
final class MyCustomContentCollectionViewCell: ContainerCollectionViewCell<MyCustomContentView> {}
```

##### Registration

Cells are registered by using the extension method `register(cellOfType:)`. The behaviour of this method is similar to the `-instantiate` method and also checks for existing `nib` files to register them or fallback to register the class.

Example:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(cellOfType: MyCustomContentTableViewCell.self)
}
```

##### Dequeue

Cells can be dequeued by using the extension method `dequeue(cellOfType: for:)`. This function automatically force casts the dequeued cell to the expected type and returns a strongly typed cell.

Example:

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(cellOfType: MyCustomContentTableViewCell.self, for: indexPath)
    cell.model = model.items[indexPath.row]
    return cell
}

// There are also additional extensions to dequeue in different ways...
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeue(cellOfType: MyCustomContentTableViewCell.self, for: indexPath) { indexPath in 
        return model.items[indexPath.row]
    }
}
```


### Modules

- [WeakCache](Modules/WeakCache)
- [PageView](Modules/PageView)
- [GridView](Modules/GridView)
- [CarouselView](Modules/CarouselView)
- [BarcodeScanner](Modules/BarcodeScanner)
- [TimePickerView](Modules/TimePickerView)
- [MessageView](Modules/MessageView)

## Contributing

We welcome everyone to work with us together delivering helpful tooling to our open source community. 
Feel free to create an issue to ask questions, give feedback, report bugs or share your new feature ideas. 
Before creating pull requests please ensure that you have created a related issue ticket.

## License

The project license can be found [here](/LICENSE).
