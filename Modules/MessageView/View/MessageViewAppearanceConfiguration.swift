//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import UIKit

public struct MessageViewAppearanceConfiguration {
    /// The position the message view should be animated from.
    public enum Position {
        /// The message view will be animated from top.
        case top
        
        /// The message view will be animated from bottom.
        case bottom
    }

    /// The origin the message view should be animated from.
    public let position: Position
    /// The top spacing the message view should have.
    public let topSpacing: CGFloat
    /// The leading space between the leading of the screen and the message view.
    public let leadingSpacing: CGFloat
    /// The trailing space between the trailing of the screen and the message view.
    public let trailingSpacing: CGFloat
    /// The bottom spacing the message view should have.
    public let bottomSpacing: CGFloat
    /// The background color of the message view.
    public let messageViewBackgroundColor: UIColor
    /// The corner radius of the message view.
    public let cornerRadius: CGFloat
    /// Indicator whether the message view should be embedded in a full screen view to block user interaction.
    public let shouldHaveBackgroundView: Bool
    /// The background color of the background view.
    public let backgroundViewBackgroundColor: UIColor
    /// Indicator whether a swipe gesture recognizer should be added.
    public let shouldAddSwipeGestureRecognizer: Bool
    /// Indicator whether an overlay button should be added.
    public let shouldAddOverlayButton: Bool

    /**
     * The initializer for `MessageViewAppearanceConfiguration`.
     *
     * - Parameter position: The origin the message view should be animated from.
     * - Parameter topSpacing: The top spacing the message view should have.
     * - Parameter leadingSpacing: The leading space between the leading of the screen and the message view.
     * - Parameter trailingSpacing: The trailing space between the trailing of the screen and the message view.
     * - Parameter bottomSpacing: The bottom spacing the message view should have.
     * - Parameter messageViewBackgroundColor: The background color of the message view.
     * - Parameter cornerRadius: The corner radius of the message view.
     * - Parameter shouldHaveBackgroundView: Indicator whether the message view should be embedded in a full screen view to block user interaction.
     * - Parameter backgroundViewBackgroundColor: The background color of the background view.
     * - Parameter shouldAddSwipeGestureRecognizer: Indicator whether a swipe gesture recognizer should be added.
     * - Parameter shouldAddOverlayButton: Indicator whether an overlay button should be added.
     */
    public init(
        position: Position = Self.default.position,
        topSpacing: CGFloat = Self.default.topSpacing,
        leadingSpacing: CGFloat = Self.default.leadingSpacing,
        trailingSpacing: CGFloat = Self.default.trailingSpacing,
        bottomSpacing: CGFloat = Self.default.bottomSpacing,
        messageViewBackgroundColor: UIColor = Self.default.messageViewBackgroundColor,
        cornerRadius: CGFloat = Self.default.cornerRadius,
        shouldHaveBackgroundView: Bool = Self.default.shouldHaveBackgroundView,
        backgroundViewBackgroundColor: UIColor = Self.default.backgroundViewBackgroundColor,
        shouldAddSwipeGestureRecognizer: Bool = Self.default.shouldAddSwipeGestureRecognizer,
        shouldAddOverlayButton: Bool = Self.default.shouldAddOverlayButton
    ) {
        self.position = position
        self.topSpacing = topSpacing
        self.leadingSpacing = leadingSpacing
        self.trailingSpacing = trailingSpacing
        self.bottomSpacing = bottomSpacing
        self.messageViewBackgroundColor = messageViewBackgroundColor
        self.cornerRadius = cornerRadius
        self.shouldHaveBackgroundView = shouldHaveBackgroundView
        self.backgroundViewBackgroundColor = backgroundViewBackgroundColor
        self.shouldAddSwipeGestureRecognizer = shouldAddSwipeGestureRecognizer
        self.shouldAddOverlayButton = shouldAddOverlayButton
    }
}

extension MessageViewAppearanceConfiguration {
    public static let `default`: Self = .init(
        position: .bottom,
        topSpacing: 0.0,
        leadingSpacing: 0.0,
        trailingSpacing: 0.0,
        bottomSpacing: 0.0,
        messageViewBackgroundColor: .white,
        cornerRadius: 0.0,
        shouldHaveBackgroundView: false,
        backgroundViewBackgroundColor: UIColor.black.withAlphaComponent(0.3),
        shouldAddSwipeGestureRecognizer: true,
        shouldAddOverlayButton: true
    )
}
