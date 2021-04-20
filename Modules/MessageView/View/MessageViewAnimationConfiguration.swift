//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import UIKit

public struct MessageViewAnimationConfiguration {
    /// The animation duration used for origin animation.
    public let animationDuration: Double
    /// The animation options to use with the animation.
    public let animationOptions: UIView.AnimationOptions

    /**
     * The initializer for `MessageViewAnimationConfiguration`.
     *
     * - Parameter animationDuration : The animation duration used for origin animation.
     * - Parameter animationOptions : The animation options to use with the animation.
     */
    public init(
        animationDuration: Double = Self.default.animationDuration,
        animationOptions: UIView.AnimationOptions = Self.default.animationOptions
    ) {
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
    }
}

extension MessageViewAnimationConfiguration {
    public static let `default`: Self = .init(
        animationDuration: 1.0,
        animationOptions: [.curveEaseInOut]
    )
}
