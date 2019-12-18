import Foundation
import JamitFoundation
import UIKit

/// The state view model for `GridView`.
public struct GridViewModel<Item: ViewModelProtocol>: ViewModelProtocol {
    /// The content insets to be applied on the grid view.
    public let insets: UIEdgeInsets

    /// The spacing between the item views inside the grid view.
    public let spacing: CGSize

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
        numberOfColumns: Int = GridViewModel.default.numberOfColumns,
        items: [Item] = GridViewModel.default.items
    ) {
        self.insets = insets
        self.spacing = spacing
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
            numberOfColumns: 1,
            items: []
        )
    }
}
