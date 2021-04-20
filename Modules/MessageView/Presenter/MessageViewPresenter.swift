// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

/// The message view presenter used to show `MessageView`s
public final class MessageViewPresenter {
    private var backgroundView: UIView?
    private var currentMessageContent: MessageContent?
    private var messageContents: [MessageContent] = []
    private var timer: Timer?

    private func addToQueue(_ messageView: MessageContent) {
        messageContents.append(messageView)
    }

    private func present(_ messageContent: MessageContent) {
        guard currentMessageContent == nil else { return addToQueue(messageContent) }

        currentMessageContent = messageContent
        attach(messageView: messageContent.messageView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }

            messageContent.messageView.showMessageView()
            switch messageContent.hideOption {
            case let .timer(time):
                self.timer = Timer.scheduledTimer(
                    timeInterval: TimeInterval(time),
                    target: self,
                    selector: #selector(self.dismissCurrentMessage),
                    userInfo: nil,
                    repeats: false
                )

            case .userControlled:
                break
            }
        }
    }

    private func attach(messageView: MessageView) {
        guard let window = UIApplication.shared.windows.last else { return }

        if messageView.model.appearanceConfiguration.shouldHaveBackgroundView {
            let backgroundView: UIView = .init(frame: window.bounds)
            backgroundView.backgroundColor = messageView.model.appearanceConfiguration.backgroundViewBackgroundColor
            let tapGestureRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(handleBackgroundTap))
            backgroundView.addGestureRecognizer(tapGestureRecognizer)
            self.backgroundView = backgroundView
            window.addSubview(backgroundView)

            backgroundView.addSubview(messageView)
        } else {
            window.addSubview(messageView)
        }

        let topSpacing: CGFloat = messageView.model.appearanceConfiguration.topSpacing
        let leadingSpacing: CGFloat = messageView.model.appearanceConfiguration.leadingSpacing
        let trailingSpacing: CGFloat = messageView.model.appearanceConfiguration.trailingSpacing
        let bottomSpacing: CGFloat = messageView.model.appearanceConfiguration.bottomSpacing

        let targetSize = CGSize(
            width: UIScreen.main.bounds.width - leadingSpacing - trailingSpacing,
            height: UIView.layoutFittingCompressedSize.height
        )

        let fittingSize = messageView.model.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.leftAnchor.constraint(equalTo: window.leftAnchor, constant: leadingSpacing).isActive = true
        messageView.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -trailingSpacing).isActive = true
        messageView.heightAnchor.constraint(equalToConstant: fittingSize.height).isActive = true

        switch messageView.model.appearanceConfiguration.position {
        case .top:
            messageView.topAnchor.constraint(equalTo: window.topAnchor, constant: topSpacing).isActive = true

        default:
            messageView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -bottomSpacing).isActive = true
        }
    }

    @objc
    private func dismissCurrentMessage() {
        currentMessageContent?.messageView.hideMessageView()
    }

    private func hide() {
        timer?.invalidate()
        timer = nil
        currentMessageContent?.messageView.removeFromSuperview()
        currentMessageContent = nil

        backgroundView?.removeFromSuperview()
        backgroundView = nil

        currentMessageContent?.completion?()

        guard let firstMessageContent = messageContents.first else { return }

        messageContents.removeFirst()
        present(firstMessageContent)
    }

    @objc
    private func handleBackgroundTap() {
        currentMessageContent?.messageView.hideMessageView()
    }

    /**
     * The initialiser for the `MessageViewPresenter`.
     */
    public init() {
        // Nothing to do here.
    }

    /**
     * Dismiss all message views.
     *
     * - Parameter animated: Decide whether the hiding is animared or not.
     */
    public func dismissAllMessages(animated: Bool = true) {
        messageContents = []

        guard animated else { return hide() }

        currentMessageContent?.messageView.hideMessageView()
    }

    /**
     * Dismiss the latest message view.
     *
     * - Parameter animated: Decide whether the hiding is animared or not.
     */
    public func dismissLatest(animated: Bool = true) {
        guard animated else { return hide() }

        currentMessageContent?.messageView.hideMessageView()
    }
}

extension MessageViewPresenter {
    /**
     * Show a message with the given content view.
     *
     * - Parameter contenView: The content view to embed into the message view.
     * - Parameter appearanceConfiguration: The appearance configuration to use for the `MessageView`
     * - Parameter animationConfiguration: The animation configuration to use for the `MessageView`.
     * - Parameter hideOption: The hide option used to hide the message.
     * - Parameter completion: The completion called when the message view was hidden.
     */
    public func show(
        contentView: UIView,
        appearanceConfiguration: MessageViewAppearanceConfiguration,
        animationConfiguration: MessageViewAnimationConfiguration,
        hideOption: MessageContent.HideOption = .userControlled,
        completion: VoidCallback? = nil
    ) {
        let messageView: MessageView = .instantiate()
        messageView.model = .init(
            contentView: contentView,
            appearanceConfiguration: appearanceConfiguration,
            animationConfiguration: animationConfiguration
        ) { [weak self] in
            self?.hide()
        }

        let messageContent: MessageContent = .init(messageView: messageView, hideOption: hideOption, completion: completion)
        present(messageContent)
    }
}
