import Foundation
import JamitFoundation
import UIKit

/// The height configuration for a row inside a `GridView`.
public enum GridHeight {
    /// Describes a row height which is equal to the column width.
    case symmetric

    /// Describes a constant row height with a given floating point value.
    case constant(CGFloat)
}

/// The state view model for `GridView`.
public struct GridViewModel<Item: ViewModelProtocol>: ViewModelProtocol {
    /// The content insets to be applied on the grid view.
    public let insets: UIEdgeInsets

    /// The spacing between the item views inside the grid view.
    public let spacing: CGSize

     /// The height configuration to be used for the rows.
    public let height: GridHeight

    /// The number of columns inside a grid view row.
    public let numberOfColumns: Int

    /// The state view model of the items to be presented.
    public let items: [Item]

    /// The default initializer of `GridViewModel`.
    ///
    /// - Parameters:
    ///   - insets: The content insets to be applied on the grid view.
    ///   - spacing: The spacing between the item views inside the grid view.
    ///   - numberOfColumns: The number of columns inside a grid view row.
    ///   - items: The state view model of the items to be presented.
    public init(
        insets: UIEdgeInsets = GridViewModel.default.insets,
        spacing: CGSize = GridViewModel.default.spacing,
        height: GridHeight = GridViewModel.default.height,
        numberOfColumns: Int = GridViewModel.default.numberOfColumns,
        items: [Item] = GridViewModel.default.items
    ) {
        self.insets = insets
        self.spacing = spacing
        self.height = height
        self.numberOfColumns = numberOfColumns
        self.items = items
    }
}

extension GridViewModel {
    /// The default state of `GridViewModel`.
    public static var `default`: GridViewModel<Item> {
        return .init(
            insets: .zero,
            spacing: .zero,
            height: .symmetric,
            numberOfColumns: 1,
            items: []
        )
    }
}
