//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import UIKit

/// The configuration of the `MessageViewPresenter`. Use this to configure the appearance and showing of messages.
public struct MessageViewPresenterConfiguration {
    /// The top space between the top of the screen and the message view.
    public let topSpacing: CGFloat
    /// The leading space between the leading of the screen and the message view.
    public let leadingSpacing: CGFloat
    /// The trailing space between the trailing of the screen and the message view.
    public let trailingSpacing: CGFloat
    /// The bottom space between the bottom of the screen and the message view.
    public let bottomSpacing: CGFloat
    /// The corner radius of the message view.
    public let cornerRadius: CGFloat
    /// The background color of the message view.
    public let messageViewBackgroundColor: UIColor
    /// The animation duration used for origin animation.
    public let animationDuration: Double
    /// The animation options to use with the animation.
    public let animationOptions: UIView.AnimationOptions
    /// Indicator whether a swipe gesture recognizer should be added.
    public let shouldAddSwipeGestureRecognizer: Bool
    /// Indicator whether an overlay button should be added.
    public let shouldAddOverlayButton: Bool

    /**
     * Initialiser of the `MessageViewPresenterConfiguration`.
     * 
     * - Parameter topSpacing: The top space between the top of the screen and the message view.
     * - Parameter leadingSpacing: The leading space between the leading of the screen and the message view.
     * - Parameter trailingSpacing: The trailing space between the trailing of the screen and the message view.
     * - Parameter bottomSpacing: The bottom space between the bottom of the screen and the message view.
     * - Parameter cornerRadius: The corner radius of the message view.
     * - Parameter messageViewBackgroundColor: The background color of the message view.
     * - Parameter animationDuration: The animation duration used for origin animation.
     * - Parameter animationOptions: The animation options to use with the animation.
     * - Parameter shouldAddSwipeGestureRecognizer: Indicator whether a swipe gesture recognizer should be added.
     * - Parameter shouldAddOverlayButton: Indicator whether an overlay button should be added.
     */
    public init(
        topSpacing: CGFloat = Self.default.topSpacing,
        leadingSpacing: CGFloat = Self.default.leadingSpacing,
        trailingSpacing: CGFloat = Self.default.trailingSpacing,
        bottomSpacing: CGFloat = Self.default.bottomSpacing,
        cornerRadius: CGFloat = Self.default.cornerRadius,
        messageViewBackgroundColor: UIColor = Self.default.messageViewBackgroundColor,
        animationDuration: Double = Self.default.animationDuration,
        animationOptions: UIView.AnimationOptions = Self.default.animationOptions,
        shouldAddSwipeGestureRecognizer: Bool = Self.default.shouldAddSwipeGestureRecognizer,
        shouldAddOverlayButton: Bool = Self.default.shouldAddOverlayButton
    ) {
        self.topSpacing = topSpacing
        self.leadingSpacing = leadingSpacing
        self.trailingSpacing = trailingSpacing
        self.bottomSpacing = bottomSpacing
        self.cornerRadius = cornerRadius
        self.messageViewBackgroundColor = messageViewBackgroundColor
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
        self.shouldAddSwipeGestureRecognizer = shouldAddSwipeGestureRecognizer
        self.shouldAddOverlayButton = shouldAddOverlayButton
    }
}

extension MessageViewPresenterConfiguration {
    public static let `default`: Self = .init(
        topSpacing: 40.0,
        leadingSpacing: 20.0,
        trailingSpacing: 20.0,
        bottomSpacing: 20.0,
        cornerRadius: 10.0,
        messageViewBackgroundColor: .blue,
        animationDuration: 1.0,
        animationOptions: [.curveEaseInOut],
        shouldAddSwipeGestureRecognizer: true,
        shouldAddOverlayButton: true
    )
}
