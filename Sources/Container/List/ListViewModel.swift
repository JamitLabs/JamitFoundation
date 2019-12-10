import Foundation
import UIKit

/// The height configuration for a row inside a `ListViewController`.
public enum ListHeight {
    /// Describes a constant row height with a given floating point value.
    case constant(CGFloat)
    /// Describes a dynamic row height with optionally a given estimated height as floating point value.
    case dynamic(CGFloat?)
}

/// The state view model for `ListViewController`.
public struct ListViewModel<Model: ViewModelProtocol>: ViewModelProtocol {
    /// The height configuration to be used for the rows.
    public let height: ListHeight

    /// The state view models for the rows inside the `ListViewController`.
    public let items: [Model]

    /// The default initializer of `ListViewModel`.
    ///
    /// - Parameter height: The height configuration to be used for the rows.
    /// - Parameter items: The state view models for the rows inside the `ListViewController`.
    public init(
        height: ListHeight = ListViewModel.default.height,
        items: [Model] = ListViewModel.default.items
    ) {
        self.height = height
        self.items = items
    }
}

extension ListViewModel {
    /// The default state of `ListViewModel`.
    public static var `default`: ListViewModel<Model> { return .init(height: .dynamic(nil), items: []) }
}
