//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation

/// The message content holding the necessary information to show a message.
public struct MessageContent {
    ///The hide options a message can have.
    public enum HideOption {
        /// The message will be hidden through user interaction.
        case userControlled
        /// The message will be hidden after the given time in seconds.
        case timer(Int)
    }

    /// The message view to show.
    public let messageView: MessageView
    /// The hide option used to hide the message.
    public let hideOption: HideOption
    /// The equtable evaluated to determine equal messages.
    public let equatable: String?
    /// The completion called when the message was hidden.
    public let completion: VoidCallback?

    /**
     * The initializer for the `MessageContent`.
     *
     * - Parameter messageView: The message view to show.
     * - Parameter hideOption: The hide option used to hide the message.
     * - Parameter equatable: The equtable evaluated to determine equal messages.
     * - Parameter completion: The completion called when the message was hidden.
     */
    public init(
        messageView: MessageView,
        hideOption: HideOption,
        equatable: String?,
        completion: VoidCallback?
    ) {
        self.messageView = messageView
        self.hideOption = hideOption
        self.equatable = equatable
        self.completion = completion
    }
}
