// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

/// The state view model for `MessageView`
public struct MessageViewModel: ViewModelProtocol {
    /// The content view to embed into the message view.
    public let contentView: UIView
    /// The appearance configuration to use for the `MessageView`.
    public let appearanceConfiguration: MessageViewAppearanceConfiguration
    /// The animation configuration to use for the `MessageView`.
    public let animationConfiguration: MessageViewAnimationConfiguration
    /// The completion called when the message view was hidden.
    public let completion: VoidCallback?

    /**
     * The initializer for `MessageViewModel`.
     *
     * - Parameter contentView: The content view to embed into the message view.
     * - Parameter appearanceConfiguration: The appearance configuration to use for the `MessageView`
     * - Parameter animationConfiguration: The animation configuration to use for the `MessageView`.
     * - Parameter completion: The completion when the message view was hidden.
     */
    public init(
        contentView: UIView = Self.default.contentView,
        appearanceConfiguration: MessageViewAppearanceConfiguration = Self.default.appearanceConfiguration,
        animationConfiguration: MessageViewAnimationConfiguration = Self.default.animationConfiguration,
        completion: VoidCallback? = Self.default.completion
    ) {
        self.contentView = contentView
        self.appearanceConfiguration = appearanceConfiguration
        self.animationConfiguration = animationConfiguration
        self.completion = completion
    }
}

extension MessageViewModel {
    /// The default state of `MessageViewModel`
    public static var `default`: Self {
        return .init(
            contentView: UIView(),
            appearanceConfiguration: .default,
            animationConfiguration: .default,
            completion: nil
        )
    }
}
