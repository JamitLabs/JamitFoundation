// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

public class MessageViewPresenter {
    private let configuration: MessageViewPresenterConfiguration

    private var backgroundView: UIView?
    private var currentMessageView: MessageView?
    private var messageViews: [MessageView] = []

    private func addToQueue(_ messageView: MessageView) {
        messageViews.append(messageView)
    }

    private func present(_ messageView: MessageView) {
        guard currentMessageView == nil else { return addToQueue(messageView) }

        currentMessageView = messageView
        attach(messageView: messageView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            messageView.showMessageView()
        }
    }

    private func attach(messageView: MessageView) {
        guard let window = UIApplication.shared.windows.last else { return }

        if messageView.model.shouldHaveBackgroundView {
            let backgroundView: UIView = .init(frame: window.bounds)
            backgroundView.backgroundColor = messageView.model.backgroundViewBackgroundColor
            let tapGestureRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(handleBackgroundTap))
            backgroundView.addGestureRecognizer(tapGestureRecognizer)
            self.backgroundView = backgroundView
            window.addSubview(backgroundView)

            backgroundView.addSubview(messageView)
        } else {
            window.addSubview(messageView)
        }

        let targetSize = CGSize(
            width: UIScreen.main.bounds.width - configuration.leadingSpacing - configuration.trailingSpacing,
            height: UIView.layoutFittingCompressedSize.height
        )
        let size = messageView.model.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        messageView.frame = .init(
            x: configuration.leadingSpacing,
            y: messageView.model.position == .bottom ? UIScreen.main.bounds.height : -size.height,
            width: size.width,
            height: size.height
        )
    }

    private func hide(_ completion: VoidCallback?) {
        currentMessageView?.removeFromSuperview()
        currentMessageView = nil

        backgroundView?.removeFromSuperview()
        backgroundView = nil

        completion?()

        guard let firstMessageView = messageViews.first else { return }

        messageViews.removeFirst()
        present(firstMessageView)
    }

    @objc
    private func handleBackgroundTap() {
        currentMessageView?.hideMessageView()
    }

    public init(configuration: MessageViewPresenterConfiguration) {
        self.configuration = configuration
    }
}

extension MessageViewPresenter {
    public func showInfo(
        contentView: UIView,
        position: MessageViewModel.Position = .bottom,
        shouldHaveBackgroundView: Bool = true,
        with backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3),
        completion: VoidCallback? = nil
    ) {
        let messageView: MessageView = .instantiate()
        messageView.model = .init(
            contentView: contentView,
            position: position,
            topSpacing: configuration.topSpacing,
            bottomSpacing: configuration.bottomSpacing,
            messageViewBackgroundColor: configuration.messageViewBackgroundColor,
            cornerRadius: configuration.cornerRadius,
            animationDuration: configuration.animationDuration,
            animationOptions: configuration.animationOptions,
            shouldHaveBackgroundView: shouldHaveBackgroundView,
            backgroundViewBackgroundColor: backgroundColor,
            shouldAddSwipeGestureRecognizer: configuration.shouldAddSwipeGestureRecognizer,
            shouldAddOverlayButton: configuration.shouldAddOverlayButton
        ) { [weak self] in
            self?.hide(completion)
        }

        present(messageView)
    }
}
