import Foundation
import UIKit

/// A data structure describing the border style of a `UIView`.
public struct BorderStyle {
    /// The color of the border.
    public let color: UIColor

    /// The width of the border.
    public let width: CGFloat

    /// The corner radius of the border.
    public let radius: Radius
}

extension UIView {
    /// The border style descriptor of a `UIView`.
    public var borderStyle: BorderStyle {
        get {
            return BorderStyle(
                color: layer.borderColor.flatMap(UIColor.init(cgColor:)) ?? .clear,
                width: layer.borderWidth,
                radius: .all(layer.cornerRadius)
            )
        }

        set {
            layer.borderColor = newValue.color.cgColor
            layer.borderWidth = newValue.width

            switch newValue.radius {
            case let .all(value):
                layer.cornerRadius = value

            case .circular:
                layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
            }
        }
    }
}
