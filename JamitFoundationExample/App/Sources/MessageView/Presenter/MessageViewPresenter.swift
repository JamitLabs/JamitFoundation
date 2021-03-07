// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import MessageView
import UIKit

final class MessageViewPresenter {
    private var backgroundView: UIView?
    private var currentMessageView: MessageView?
    private var messageViews: [MessageView] = []

    private let topSpacing: CGFloat = 40.0
    private let leadingSpacing: CGFloat = 20.0
    private let trailingSpacing: CGFloat = 20.0
    private let bottomSpacing: CGFloat = 20.0
    private let cornerRadius: CGFloat = 10.0

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

        let heightOffset: CGFloat = 10.0
        let height: CGFloat = messageView.model.contentView.bounds.height + heightOffset
        let bounds: CGRect = .init(
            x: leadingSpacing,
            y: messageView.model.origin == .bottom ? UIScreen.main.bounds.height : -height,
            width: UIScreen.main.bounds.width - leadingSpacing - trailingSpacing,
            height: height
        )

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

        messageView.frame = bounds
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
}

extension MessageViewPresenter {
    func showInfo(
        withTitle title: String,
        andMessage message: String,
        origin: MessageViewModel.Origin = .bottom,
        shouldHaveBackgroundView: Bool = true,
        with backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3),
        completion: VoidCallback? = nil
    ) {
        let infoMessageView: InfoMessageView = .instantiate()
        infoMessageView.model = .init(
            title: title,
            message: message
        )

        let messageView: MessageView = .instantiate()
        messageView.model = .init(
            contentView: infoMessageView,
            origin: origin,
            topSpacing: topSpacing,
            leadingSpacing: leadingSpacing,
            trailingSpacing: trailingSpacing,
            bottomSpacing: bottomSpacing,
            messageViewBackgroundColor: .blue,
            cornerRadius: cornerRadius,
            animationDuration: 1.0,
            animationOptions: [.curveEaseInOut],
            shouldHaveBackgroundView: shouldHaveBackgroundView,
            backgroundViewBackgroundColor: backgroundColor
        ) { [weak self] in
            self?.hide(completion)
        }

        present(messageView)
    }
}
