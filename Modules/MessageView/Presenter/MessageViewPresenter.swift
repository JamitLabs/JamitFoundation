// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

/// The message view presenter used to show `MessageView`s
public final class MessageViewPresenter {
    private let configuration: MessageViewPresenterConfiguration

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

        let fittingSize = messageView.model.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.leftAnchor.constraint(equalTo: window.leftAnchor, constant: configuration.leadingSpacing).isActive = true
        messageView.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -configuration.trailingSpacing).isActive = true
        messageView.heightAnchor.constraint(equalToConstant: fittingSize.height).isActive = true

        switch messageView.model.position {
        case .top:
            messageView.topAnchor.constraint(equalTo: window.topAnchor, constant: configuration.topSpacing).isActive = true

        default:
            messageView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -configuration.bottomSpacing).isActive = true
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
     * 
     * - Parameter configuration: The configuration used to adjust the appearance and showing of message views.
     */
    public init(configuration: MessageViewPresenterConfiguration) {
        self.configuration = configuration
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
     * - Parameter position: The origin the message view should be animated from.
     * - Parameter shouldHaveBackgroundView: Indicator whether the message view should be embedded in a full screen view to block user interaction.
     * - Parameter backgroundColor: The background color of the background view.
     * - Parameter hideOption: The hide option used to hide the message.
     * - Parameter completion: The completion called when the message view was hidden.
     */
    public func show(
        contentView: UIView,
        position: MessageViewModel.Position = .bottom,
        shouldHaveBackgroundView: Bool = true,
        with backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3),
        hideOption: MessageContent.HideOption = .userControlled,
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
            self?.hide()
        }

        let messageContent: MessageContent = .init(messageView: messageView, hideOption: hideOption, completion: completion)
        present(messageContent)
    }
}
