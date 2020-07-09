//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

/// The state view model for `CollapsibleView`.
public struct CollapsibleViewModel: ViewModelProtocol {
    /// The header view to embed.
    public let headerView: UIView
    /// The items to add to the collapsible view.
    public let items: [UIView]
    /// The state of the collapsible view
    public var isCollapsed: Bool
    /// The animation duration for the state change of the collapsible view
    public let animationDuration: TimeInterval

    /// The default initializer of `CollapsibleViewModel`.
    ///
    /// - Parameter headerView: The header view to embed.
    /// - Parameter items: The items to add to the collapsible view.
    /// - Parameter isCollapsed: The state of the collapsible view
    /// - Parameter animationDuration: The animation duration for the state change of the collapsible view
    public init(
        headerView: UIView = Self.default.headerView,
        items: [UIView] = Self.default.items,
        isCollapsed: Bool = Self.default.isCollapsed,
        animationDuration: TimeInterval = Self.default.animationDuration
    ) {
        self.headerView = headerView
        self.items = items
        self.isCollapsed = isCollapsed
        self.animationDuration = animationDuration
    }
}

extension CollapsibleViewModel {
    /// The default state of `CollapsibleViewModel`.
    public static let `default`: Self = .init(
        headerView: UIView(),
        items: [],
        isCollapsed: false,
        animationDuration: 0.3
    )
}
