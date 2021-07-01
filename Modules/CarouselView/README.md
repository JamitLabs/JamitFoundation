#  CarouselView

The carousel view adds carousel scroll behaviour to an embedded generic `ContentView`.

Example:
```swift
// The image urls to be presented as content
let imageSourceURLs: [URL] = [<#image sources#>]

// Instantiate carousel view with `ImageView` as content views
let contentView = CarouselView<ImageView>.instantiate()

// Configure the model of the carousel view by mapping the images
contentView.model = .init(pages: imageSourceURLs.map { .url($0) })
```
