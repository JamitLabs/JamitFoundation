#  PageView

The page view adds paged scroll behaviour to an embedded `ContentView`.

Example:

```swift
// The image urls to be presented as content
let imageSourceURLs: [URL] = [<#image sources#>]

// Instantiate a page view with image views as content
let contentView = PageView<ImageView>.instantiate()

// Configure the model
contentView.model = .init(pages: imageSourceURLs.map { .url($0) })
```
