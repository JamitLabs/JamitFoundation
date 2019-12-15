import Foundation
import JamitFoundation
import UIKit

// TODO: Write documentation for public interface!

public struct GridViewModel<Item: ViewModelProtocol>: ViewModelProtocol {
    public let insets: UIEdgeInsets
    public let spacing: CGSize
    public let numberOfColumns: Int
    public let items: [Item]

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
