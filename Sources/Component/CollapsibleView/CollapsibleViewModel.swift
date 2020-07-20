//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

/// The state view model for `CollapsibleView`.
public struct CollapsibleViewModel<HeaderViewModel: ViewModelProtocol>: ViewModelProtocol {
    /// The header view to embed.
    public let headerViewModel: HeaderViewModel
    /// The items to add to the collapsible view.
    public let items: [UIView]
    /// The state of the collapsible view
    public var isCollapsed: Bool
    /// The animation duration for the state change of the collapsible view
    public let animationDuration: TimeInterval
    public var didChangeCollapsibleState: ((Bool) -> Void)?

    /// The default initializer of `CollapsibleViewModel`.
    ///
    /// - Parameter headerViewModel: The model of the header view.
    /// - Parameter items: The items to add to the collapsible view.
    /// - Parameter isCollapsed: The state of the collapsible view
    /// - Parameter animationDuration: The animation duration for the state change of the collapsible view
    public init(
        headerViewModel: HeaderViewModel = Self.default.headerViewModel,
        items: [UIView] = Self.default.items,
        isCollapsed: Bool = Self.default.isCollapsed,
        animationDuration: TimeInterval = Self.default.animationDuration,
        didChangeCollapsibleState: ((Bool) -> Void)? = Self.default.didChangeCollapsibleState
    ) {
        self.headerViewModel = headerViewModel
        self.items = items
        self.isCollapsed = isCollapsed
        self.animationDuration = animationDuration
        self.didChangeCollapsibleState = didChangeCollapsibleState
    }
}

extension CollapsibleViewModel {
    /// The default state of `CollapsibleViewModel`.
    public static var `default`: CollapsibleViewModel<HeaderViewModel> {
        .init(
            headerViewModel: .default,
            items: [],
            isCollapsed: false,
            animationDuration: 0.0,
            didChangeCollapsibleState: nil
        )
    }
}
