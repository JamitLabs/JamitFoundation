// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

/// The state view model for `MessageView`
public struct MessageViewModel: ViewModelProtocol {
    /// The origin the message view should be animated from
    public enum Origin {
        /// The message view will be animated from top.
        case top
        
        /// The message view will be animated from bottom
        case bottom
    }

    /// The content view to embed into the message view
    public let contentView: UIView
    /// The origin the message view should be animated from
    public let origin: Origin
    /// The top spacing the message view should have
    public let topSpacing: CGFloat
    /// The leading spacing the message view should have
    public let leadingSpacing: CGFloat
    /// The trailing spacing the message view should have
    public let trailingSpacing: CGFloat
    /// The bottom spacing the message view should have
    public let bottomSpacing: CGFloat
    /// The background color of the message view
    public let contentViewBackgroundColor: UIColor
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
    /// The action when the message view was hidden
    public let action: VoidCallback?

    /// The initializer for `MessageViewModel`
    ///
    /// - Parameters:
    ///  - contentView: The content view to embed into the message view
    ///  - origin: The origin the message view should be animated from
    ///  - topSpacing: The top spacing the message view should have
    ///  - leadingSpacing: The leading spacing the message view should have
    ///  - trailingSpacing: The trailing spacing the message view should have
    ///  - bottomSpacing: The bottom spacing the message view should have
    ///  - contentViewBackgroundColor: The background color of the message view
    ///  - cornerRadius: The corner radius of the message view
    ///  - animationDuration : The animation duration used for origin animation
    ///  - animationOptions : The animation options to use with the animation
    ///  - shouldHaveBackgroundView : Indicator whether the message view should be embedded in a full screen view to block user interaction
    ///  - backgroundViewBackgroundColor : The background color of the background view
    ///  - action: The action when the message view was hidden
    public init(
        contentView: UIView = Self.default.contentView,
        origin: Origin = Self.default.origin,
        topSpacing: CGFloat = Self.default.topSpacing,
        leadingSpacing: CGFloat = Self.default.leadingSpacing,
        trailingSpacing: CGFloat = Self.default.trailingSpacing,
        bottomSpacing: CGFloat = Self.default.bottomSpacing,
        contentViewBackgroundColor: UIColor = Self.default.contentViewBackgroundColor,
        cornerRadius: CGFloat = Self.default.cornerRadius,
        animationDuration: Double = Self.default.animationDuration,
        animationOptions: UIView.AnimationOptions = Self.default.animationOptions,
        shouldHaveBackgroundView: Bool = Self.default.shouldHaveBackgroundView,
        backgroundViewBackgroundColor: UIColor = Self.default.backgroundViewBackgroundColor,
        action: VoidCallback? = Self.default.action
    ) {
        self.contentView = contentView
        self.origin = origin
        self.topSpacing = topSpacing
        self.leadingSpacing = leadingSpacing
        self.trailingSpacing = trailingSpacing
        self.bottomSpacing = bottomSpacing
        self.contentViewBackgroundColor = contentViewBackgroundColor
        self.cornerRadius = cornerRadius
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
        self.shouldHaveBackgroundView = shouldHaveBackgroundView
        self.backgroundViewBackgroundColor = backgroundViewBackgroundColor
        self.action = action
    }
}

extension MessageViewModel {
    /// The default state of `MessageViewModel`
    public static var `default`: Self {
        return .init(
            contentView: UIView(),
            origin: .bottom,
            topSpacing: 0.0,
            leadingSpacing: 0.0,
            trailingSpacing: 0.0,
            bottomSpacing: 0.0,
            contentViewBackgroundColor: .white,
            cornerRadius: 0.0,
            animationDuration: 1.0,
            animationOptions: [.curveEaseInOut],
            shouldHaveBackgroundView: false,
            backgroundViewBackgroundColor: UIColor.black.withAlphaComponent(0.3),
            action: nil
        )
    }
}
