//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import MessageView
import UIKit

extension MessageViewPresenter {
    func showInfo(
        withTitle title: String,
        andMessage message: String,
        position: MessageViewModel.Position = .bottom,
        shouldHaveBackgroundView: Bool = true,
        with backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3),
        completion: VoidCallback? = nil
    ) {
        let infoMessageView: InfoMessageView = .instantiate()
        infoMessageView.model = .init(
            title: title,
            message: message
        )

        showInfo(
            contentView: infoMessageView,
            position: position,
            shouldHaveBackgroundView: shouldHaveBackgroundView,
            with: backgroundColor,
            completion: completion
        )
    }
}
