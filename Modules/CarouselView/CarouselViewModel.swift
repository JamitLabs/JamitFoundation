import Foundation
import JamitFoundation
import UIKit

/// The state view model for `CarouselView`.
public struct CarouselViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    /// A closure type definition for the page index change callback.
    public typealias PageIndexChangeCallback = (Int) -> Void

    /// The content view models for the carousel content views.
    public let pages: [Content]

    /// The insets applied to the current active page frame.
    public let pageInset: UIEdgeInsets

    /// The insets applied to the neighboring page frames of the current active page.
    public let neighboringPageInset: UIEdgeInsets

    /// The scale applied to the neighboring page frames of the current active page.
    public let neighboringPageScaleFactor: CGFloat

    /// The callback for page index changes.
    public let onPageIndexChanged: PageIndexChangeCallback

    /// The default initializer of `CarouselViewModel`.
    ///
    /// - Parameter pages: The carousel content view models.
    /// - Parameter pageInset: The insets applied to the current active page frame.
    /// - Parameter neighboringPageInset: The insets applied to the neighboring page frames of the current active page.
    /// - Parameter neighboringPageScaleFactor: The scale applied to the neighboring page frames of the current active page.
    /// - Parameter onPageIndexChanged: The content view models for the carousel content views.
    public init(
        pages: [Content] = Self.default.pages,
        pageInset: UIEdgeInsets = Self.default.pageInset,
        neighboringPageInset: UIEdgeInsets = Self.default.neighboringPageInset,
        neighboringPageScaleFactor: CGFloat = Self.default.neighboringPageScaleFactor,
        onPageIndexChanged: @escaping PageIndexChangeCallback = Self.default.onPageIndexChanged
    ) {
        self.pages = pages
        self.pageInset = pageInset
        self.neighboringPageInset = neighboringPageInset
        self.neighboringPageScaleFactor = neighboringPageScaleFactor
        self.onPageIndexChanged = onPageIndexChanged
    }
}

extension CarouselViewModel {
    /// The default state of `CarouselViewModel`.
    public static var `default`: CarouselViewModel<Content> {
        return .init(
            pages: [],
            pageInset: .zero,
            neighboringPageInset: .zero,
            neighboringPageScaleFactor: 1.0,
            onPageIndexChanged: { _ in }
        )
    }
}
