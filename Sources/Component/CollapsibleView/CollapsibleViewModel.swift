//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

/// The state view model for `CollapsibleView`.
public struct CollapsibleViewModel<HeaderViewModel: ViewModelProtocol>: ViewModelProtocol {
    /// The header view to embed.
    public var headerViewModel: HeaderViewModel
    /// The items to add to the collapsible view.
    public var items: [UIView]
    /// The state of the collapsible view when it is first presented
    public let isInitiallyCollapsed: Bool
    /// Whether to animate the collapsing and expanding of the content items
    public var isAnimated: Bool
    /// The animation duration for the state change of the collapsible view
    public var animationDuration: TimeInterval
    /// The distribution of the content items in the collapsible view
    public var contentDistribution: UIStackView.Distribution
    /// The alignment of the content items in the collapsible view
    public var contentAlignment: UIStackView.Alignment
    /// The closure to call when the collapsible state changes.
    public var didChangeCollapsibleState: ((Bool) -> Void)?

    /// The default initializer of `CollapsibleViewModel`.
    ///
    /// - Parameter headerViewModel: The model of the header view.
    /// - Parameter items: The items to add to the collapsible view.
    /// - Parameter isCollapsed: The state of the collapsible view when it is first presented.
    ///             This will not be updated by the `CollapsibleView` on subsequent state changes.
    /// - Parameter isAnimated: Whether to animate the collapsing and expanding of the content items
    /// - Parameter animationDuration: The animation duration for the state change of the collapsible view
    /// - Parameter contentDistribution: The distribution of the content items in the collapsible view
    /// - Parameter contentAlignment: The alignment of the content items in the collapsible view
    /// - Parameter didChangeCollapsibleState: The closure to call when the collapsible state changes.
    @available(
        *,
        deprecated,
        renamed: "init(headerViewModel:items:isInitiallyCollapsed:isAnimated:animationDuration:contentDistribution:contentAlignment:didChangeCollapsibleState:)",
        message: "The isCollapsed property now only reflects the initial state of the collapsible view. Use the didChangeCollapsibleState closure to get notified about further state changes."
    )
    public init(
        headerViewModel: HeaderViewModel = Self.default.headerViewModel,
        items: [UIView] = Self.default.items,
        isCollapsed: Bool = Self.default.isInitiallyCollapsed,
        isAnimated: Bool = Self.default.isAnimated,
        animationDuration: TimeInterval = Self.default.animationDuration,
        contentDistribution: UIStackView.Distribution = Self.default.contentDistribution,
        contentAlignment: UIStackView.Alignment = Self.default.contentAlignment,
        didChangeCollapsibleState: ((Bool) -> Void)? = Self.default.didChangeCollapsibleState
    ) {
        self.headerViewModel = headerViewModel
        self.items = items
        self.isInitiallyCollapsed = isCollapsed
        self.isAnimated = isAnimated
        self.animationDuration = animationDuration
        self.contentDistribution = contentDistribution
        self.contentAlignment = contentAlignment
        self.didChangeCollapsibleState = didChangeCollapsibleState
    }

    /// The default initializer of `CollapsibleViewModel`.
    ///
    /// - Parameter headerViewModel: The model of the header view.
    /// - Parameter items: The items to add to the collapsible view.
    /// - Parameter isInitiallyCollapsed: The state of the collapsible view when it is first presented.
    ///             This will not be updated by the `CollapsibleView` on subsequent state changes.
    /// - Parameter isAnimated: Whether to animate the collapsing and expanding of the content items
    /// - Parameter animationDuration: The animation duration for the state change of the collapsible view
    /// - Parameter contentDistribution: The distribution of the content items in the collapsible view
    /// - Parameter contentAlignment: The alignment of the content items in the collapsible view
    /// - Parameter didChangeCollapsibleState: The closure to call when the collapsible state changes.
    public init(
        headerViewModel: HeaderViewModel = Self.default.headerViewModel,
        items: [UIView] = Self.default.items,
        isInitiallyCollapsed: Bool = Self.default.isInitiallyCollapsed,
        isAnimated: Bool = Self.default.isAnimated,
        animationDuration: TimeInterval = Self.default.animationDuration,
        contentDistribution: UIStackView.Distribution = Self.default.contentDistribution,
        contentAlignment: UIStackView.Alignment = Self.default.contentAlignment,
        didChangeCollapsibleState: ((Bool) -> Void)? = Self.default.didChangeCollapsibleState
    ) {
        self.headerViewModel = headerViewModel
        self.items = items
        self.isInitiallyCollapsed = isInitiallyCollapsed
        self.isAnimated = isAnimated
        self.animationDuration = animationDuration
        self.contentDistribution = contentDistribution
        self.contentAlignment = contentAlignment
        self.didChangeCollapsibleState = didChangeCollapsibleState
    }
}

extension CollapsibleViewModel {
    /// The default state of `CollapsibleViewModel`.
    public static var `default`: CollapsibleViewModel<HeaderViewModel> {
        .init(
            headerViewModel: .default,
            items: [],
            isInitiallyCollapsed: false,
            isAnimated: false,
            animationDuration: 0.0,
            contentDistribution: .fillProportionally,
            contentAlignment: .leading,
            didChangeCollapsibleState: nil
        )
    }
}
