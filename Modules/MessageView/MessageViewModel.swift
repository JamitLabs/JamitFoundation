// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

public struct MessageViewModel: ViewModelProtocol {
    public enum Origin {
        case top
        case bottom
    }

    public let contentView: UIView
    public let origin: Origin
    public let topSpacing: CGFloat
    public let leadingSpacing: CGFloat
    public let trailingSpacing: CGFloat
    public let bottomSpacing: CGFloat
    public let contentViewBackgroundColor: UIColor
    public let cornerRadius: CGFloat
    public let animationDuration: Double
    public let animationOptions: UIView.AnimationOptions
    public let shouldHaveBackgroundView: Bool
    public let backgroundViewBackgroundColor: UIColor
    public let action: VoidCallback?

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
