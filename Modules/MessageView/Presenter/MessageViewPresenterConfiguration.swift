//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

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

    /**
     * Initialiser of the `MessageViewPresenterConfiguration`.
     * 
     * - Parameter topSpacing: The top space between the top of the screen and the message view.
     * - Parameter leadingSpacing: The leading space between the leading of the screen and the message view.
     * - Parameter trailingSpacing: The trailing space between the trailing of the screen and the message view.
     * - Parameter bottomSpacing: The bottom space between the bottom of the screen and the message view.
     * - Parameter cornerRadius: The corner radius of the message view.
     */
    public init(
        topSpacing: CGFloat = Self.default.topSpacing,
        leadingSpacing: CGFloat = Self.default.leadingSpacing,
        trailingSpacing: CGFloat = Self.default.trailingSpacing,
        bottomSpacing: CGFloat = Self.default.bottomSpacing,
        cornerRadius: CGFloat = Self.default.cornerRadius
    ) {
        self.topSpacing = topSpacing
        self.leadingSpacing = leadingSpacing
        self.trailingSpacing = trailingSpacing
        self.bottomSpacing = bottomSpacing
        self.cornerRadius = cornerRadius
    }
}

extension MessageViewPresenterConfiguration {
    public static let `default`: Self = .init(
        topSpacing: 40.0,
        leadingSpacing: 20.0,
        trailingSpacing: 20.0,
        bottomSpacing: 20.0,
        cornerRadius: 10.0
    )
}
