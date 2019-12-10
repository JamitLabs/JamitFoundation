import Foundation
import UIKit

/// The state model for `ImageView` representing the data source for an image.
public enum Image {
    /// Describing am `ImageView` state which has no image source.
    case none
    /// Describing an `ImageView` state which has an `URL` as source.
    case url(URL)
    /// Describing an `ImageView` state which has an `UIImage` as source.
    case image(UIImage)
}

extension Image: ViewModelProtocol {
    /// The default state of `Image`.
    public static let `default`: Image = .none
}
