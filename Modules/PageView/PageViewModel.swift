import Foundation
import JamitFoundation
import UIKit

/// The state view model for `PageView`.
public struct PageViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    /// A closure type definition for the page index change callback.
    public typealias PageIndexChangeCallback = (Int) -> Void

    /// The scroll axis definition for the `PageView` paging behaviour.
    public enum Axis {
        /// Describes a horizontal paging behaviour for the `PageView`.
        case horizontal

        /// Describes a vertical paging behaviour for the `PageView`.
        case vertical
    }

    /// The scroll axis for the paging behaviour.
    public let axis: Axis

    /// The content view models for the paginated content views.
    public let pages: [Content]

    /// The callback for page index changes.
    public let onPageIndexChanged: PageIndexChangeCallback

    /// Wheter the PageView is vertically scrollable or not.
    public let verticalScrollEnabled: Bool

    /// The default initializer of `PageViewModel`.
    ///
    /// - Parameter axis: The scroll axis for the paging behaviour.
    /// - Parameter pages: The paginated content view models.
    /// - Parameter onPageIndexChanged: The content view models for the paginated content views.
    /// - Parameter verticalScrollEnabled: Whether the pageview is scrolling verticaly or not.
    public init(
        axis: Axis = PageViewModel.default.axis,
        pages: [Content] = PageViewModel.default.pages,
        onPageIndexChanged: @escaping PageIndexChangeCallback = PageViewModel.default.onPageIndexChanged,
        verticalScrollEnbaled: Bool = CustomPageViewModel.default.verticalScrollEnabled
    ) {
        self.axis = axis
        self.pages = pages
        self.onPageIndexChanged = onPageIndexChanged
        self.verticalScrollEnabled = verticalScrollEnbaled
    }
}

extension PageViewModel {
    /// The default state of `PageViewModel`.
    public static var `default`: PageViewModel<Content> {
        return .init(
            axis: .horizontal,
            pages: [],
            onPageIndexChanged: { _ in },
            verticalScrollEnbaled: true,
        )
    }
}
