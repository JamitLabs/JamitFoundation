//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation

public struct MessageContent {
    public enum HideOption {
        case userControlled
        case timer(Int)
    }

    public let messageView: MessageView
    public let hideOption: HideOption
    public let completion: VoidCallback?
}
