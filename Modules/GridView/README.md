#  GridView

The grid view presents a collection of generic `ItemView`s in a grid based layout.

Example:

```swift
// The image urls to be presented as content
let imageSourceURLs: [URL] = [<#image sources#>]

// Instantiation with an image view listening to touch events through the action view
let gridView: GridView<ActionView<ImageView>> = .instantiate()

// Model configuration
gridView.model = GridViewModel(
    insets: .zero,
    spacing: .zero,
    numberOfColumns: 3,
    items: imageSourceURLs.map { imageSourceURL in
        return ActionViewModel(content: .url(imageSourceURL)) { [unowned self] in
            print("Did tap image view with url: \(imageSourceURL)")
        }
    }
)
```
