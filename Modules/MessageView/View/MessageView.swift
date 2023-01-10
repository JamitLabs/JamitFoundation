// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

/// A stateful view which can be used to display messages to the user
///
/// For a detailed example have a look at the sample project as this view is mainly
/// for the use with a `MessageViewPresenter`.
///
public final class MessageView: StatefulView<MessageViewModel> {
    private lazy var button: UIButton = .instantiate()

    private var swipeUpGestureRecognizer: UISwipeGestureRecognizer {
        let swipeUpGestureRecognizer: UISwipeGestureRecognizer = .init(target: self, action: #selector(didSwipeUp))
        swipeUpGestureRecognizer.direction = .up
        return swipeUpGestureRecognizer
    }

    private var swipeDownGestureRecognizer: UISwipeGestureRecognizer {
        let swipeDownGestureRecognizer: UISwipeGestureRecognizer = .init(target: self, action: #selector(didSwipeDown))
        swipeDownGestureRecognizer.direction = .down
        return swipeDownGestureRecognizer
    }

    public override func didChangeModel() {
        super.didChangeModel()

        layer.cornerRadius = model.appearanceConfiguration.cornerRadius
        backgroundColor = model.appearanceConfiguration.messageViewBackgroundColor

        setup()

        isHidden = true
        
        button.gestureRecognizers?.removeAll()

        guard model.appearanceConfiguration.shouldAddSwipeGestureRecognizer else { return }

        switch model.appearanceConfiguration.position {
        case .top:
            if model.appearanceConfiguration.shouldAddOverlayButton {
                button.addGestureRecognizer(swipeUpGestureRecognizer)
            } else {
                model.contentView.addGestureRecognizer(swipeUpGestureRecognizer)
            }

        case .bottom:
            if model.appearanceConfiguration.shouldAddOverlayButton {
                button.addGestureRecognizer(swipeDownGestureRecognizer)
            } else {
                model.contentView.addGestureRecognizer(swipeDownGestureRecognizer)
            }
        }
    }

    private func setup() {
        subviews.forEach { $0.removeFromSuperview() }

        model.contentView.clipsToBounds = true
        model.contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(model.contentView)
        model.contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        model.contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        model.contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: model.contentView.bottomAnchor).isActive = true

        guard model.appearanceConfiguration.shouldAddOverlayButton else { return }

        addSubview(button)

        button.clipsToBounds = true
        button.constraintEdgesToParent()

        button.addTarget(self, action: #selector(didTriggerAction), for: .primaryActionTriggered)

        isUserInteractionEnabled = true

        bringSubviewToFront(button)
    }

    @objc
    private func didSwipeUp() {
        hideMessageView()
    }

    @objc
    private func didSwipeDown() {
        hideMessageView()
    }

    @objc
    private func didTriggerAction() {
        hideMessageView()
    }

    /// Show the message view
    public func showMessageView() {
        let originalY = center.y

        switch model.appearanceConfiguration.position {
        case .top:
            center.y -= (bounds.height + model.appearanceConfiguration.topSpacing)

        case .bottom:
            center.y += bounds.height + model.appearanceConfiguration.bottomSpacing
        }

        showAnimate { [weak self] in
            self?.center.y = originalY
            self?.layoutIfNeeded()
        }

        isHidden = false
    }

    private func showAnimate(animations: @escaping VoidCallback) {
        UIView.animate(
            withDuration: model.animationConfiguration.animationDuration,
            delay: 0,
            options: model.animationConfiguration.animationOptions,
            animations: {
                animations()
            },
            completion: nil
        )
    }

    /// Hide the message view
    public func hideMessageView() {
        var targetY = center.y

        switch model.appearanceConfiguration.position {
        case .top:
            targetY -= (bounds.height + model.appearanceConfiguration.topSpacing)

        case .bottom:
            targetY += bounds.height + model.appearanceConfiguration.bottomSpacing
        }

        hideAnimation(
            animations: { [weak self] in
                self?.center.y = targetY
                self?.layoutIfNeeded()
            },
            completion: { [weak self] in
                self?.isHidden = true
                self?.model.completion?()
            }
        )
    }

    private func hideAnimation(animations: @escaping VoidCallback, completion: @escaping VoidCallback) {
        UIView.animate(
            withDuration: model.animationConfiguration.animationDuration,
            delay: 0,
            options: model.animationConfiguration.animationOptions,
            animations: {
                animations()
            },
            completion: { _ in
                completion()
            }
        )
    }
}
