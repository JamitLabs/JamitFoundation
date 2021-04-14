//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import UIKit

public struct MessageViewPresenterConfiguration {
    public let topSpacing: CGFloat
    public let leadingSpacing: CGFloat
    public let trailingSpacing: CGFloat
    public let bottomSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let messageViewBackgroundColor: UIColor
    public let animationDuration: Double
    public let animationOptions: UIView.AnimationOptions
    public let shouldAddSwipeGestureRecognizer: Bool
    public let shouldAddOverlayButton: Bool

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
