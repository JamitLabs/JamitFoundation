// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

/// The state view model for `MessageView`
public struct MessageViewModel: ViewModelProtocol {
    /// The position the message view should be animated from
    public enum Position {
        /// The message view will be animated from top.
        case top
        
        /// The message view will be animated from bottom
        case bottom
    }

    /// The content view to embed into the message view
    public let contentView: UIView
    /// The origin the message view should be animated from
    public let position: Position
    /// The top spacing the message view should have
    public let topSpacing: CGFloat
    /// The bottom spacing the message view should have
    public let bottomSpacing: CGFloat
    /// The background color of the message view
    public let messageViewBackgroundColor: UIColor
    /// The corner radius of the message view
    public let cornerRadius: CGFloat
    /// The animation duration used for origin animation
    public let animationDuration: Double
    /// The animation options to use with the animation
    public let animationOptions: UIView.AnimationOptions
    /// Indicator whether the message view should be embedded in a full screen view to block user interaction
    public let shouldHaveBackgroundView: Bool
    /// The background color of the background view
    public let backgroundViewBackgroundColor: UIColor
    /// Indicator whether a swipe gesture recognizer should be added.
    public let shouldAddSwipeGestureRecognizer: Bool
    /// Indicator whether an overlay button should be added.
    public let shouldAddOverlayButton: Bool
    /// The completion when the message view was hidden
    public let completion: VoidCallback?

    /// The initializer for `MessageViewModel`
    ///
    /// - Parameters:
    ///  - contentView: The content view to embed into the message view
    ///  - position: The origin the message view should be animated from
    ///  - topSpacing: The top spacing the message view should have
    ///  - bottomSpacing: The bottom spacing the message view should have
    ///  - messageViewBackgroundColor: The background color of the message view
    ///  - cornerRadius: The corner radius of the message view
    ///  - animationDuration : The animation duration used for origin animation
    ///  - animationOptions : The animation options to use with the animation
    ///  - shouldHaveBackgroundView : Indicator whether the message view should be embedded in a full screen view to block user interaction
    ///  - backgroundViewBackgroundColor : The background color of the background view
    ///  - completion: The completion when the message view was hidden
    public init(
        contentView: UIView = Self.default.contentView,
        position: Position = Self.default.position,
        topSpacing: CGFloat = Self.default.topSpacing,
        bottomSpacing: CGFloat = Self.default.bottomSpacing,
        messageViewBackgroundColor: UIColor = Self.default.messageViewBackgroundColor,
        cornerRadius: CGFloat = Self.default.cornerRadius,
        animationDuration: Double = Self.default.animationDuration,
        animationOptions: UIView.AnimationOptions = Self.default.animationOptions,
        shouldHaveBackgroundView: Bool = Self.default.shouldHaveBackgroundView,
        backgroundViewBackgroundColor: UIColor = Self.default.backgroundViewBackgroundColor,
        shouldAddSwipeGestureRecognizer: Bool = Self.default.shouldAddSwipeGestureRecognizer,
        shouldAddOverlayButton: Bool = Self.default.shouldAddOverlayButton,
        completion: VoidCallback? = Self.default.completion
    ) {
        self.contentView = contentView
        self.position = position
        self.topSpacing = topSpacing
        self.bottomSpacing = bottomSpacing
        self.messageViewBackgroundColor = messageViewBackgroundColor
        self.cornerRadius = cornerRadius
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
        self.shouldHaveBackgroundView = shouldHaveBackgroundView
        self.backgroundViewBackgroundColor = backgroundViewBackgroundColor
        self.shouldAddSwipeGestureRecognizer = shouldAddSwipeGestureRecognizer
        self.shouldAddOverlayButton = shouldAddOverlayButton
        self.completion = completion
    }
}

extension MessageViewModel {
    /// The default state of `MessageViewModel`
    public static var `default`: Self {
        return .init(
            contentView: UIView(),
            position: .bottom,
            topSpacing: 0.0,
            bottomSpacing: 0.0,
            messageViewBackgroundColor: .white,
            cornerRadius: 0.0,
            animationDuration: 1.0,
            animationOptions: [.curveEaseInOut],
            shouldHaveBackgroundView: false,
            backgroundViewBackgroundColor: UIColor.black.withAlphaComponent(0.3),
            shouldAddSwipeGestureRecognizer: true,
            shouldAddOverlayButton: true,
            completion: nil
        )
    }
}
