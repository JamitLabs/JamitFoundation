import Foundation
import UIKit

/// A base protocol meeting all requirements of a view model for a `StatefulView`.
public protocol ViewModelProtocol {
    /// The default state of `Self`.
    static var `default`: Self { get }

    /// The background color of the view.
    var backgroundColor: UIColor { get }
}

extension ViewModelProtocol {
    /// Returns clear as default background color.
    public var backgroundColor: UIColor { return .clear }
}
