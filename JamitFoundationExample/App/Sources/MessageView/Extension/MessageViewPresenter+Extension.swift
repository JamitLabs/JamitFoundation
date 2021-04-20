//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import MessageView
import UIKit

extension MessageViewPresenter {
    func show(
        withTitle title: String,
        andMessage message: String,
        position: MessageViewAppearanceConfiguration.Position = .bottom,
        shouldHaveBackgroundView: Bool = true,
        backgroundViewColor: UIColor = UIColor.black.withAlphaComponent(0.3),
        hideOption: MessageContent.HideOption = .userControlled,
        completion: VoidCallback? = nil
    ) {
        let infoMessageView: InfoMessageView = .instantiate()
        infoMessageView.model = .init(
            title: title,
            message: message
        )

        show(
            contentView: infoMessageView,
            appearanceConfiguration: .init(
                position: position,
                topSpacing: 40.0,
                leadingSpacing: 20.0,
                trailingSpacing: 20.0,
                bottomSpacing: 20.0,
                messageViewBackgroundColor: .blue,
                cornerRadius: 10.0,
                shouldHaveBackgroundView: shouldHaveBackgroundView,
                backgroundViewBackgroundColor: backgroundViewColor,
                shouldAddSwipeGestureRecognizer: true,
                shouldAddOverlayButton: true
            ),
            animationConfiguration: .init(
                animationDuration: 1.0,
                animationOptions: [.curveEaseInOut]
            ),
            hideOption: hideOption,
            completion: completion
        )
    }
}
