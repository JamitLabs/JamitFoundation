// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

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

        layer.cornerRadius = model.cornerRadius
        backgroundColor = model.contentViewBackgroundColor

        setup()

        isHidden = true

        switch model.origin {
        case .top:
            button.addGestureRecognizer(swipeUpGestureRecognizer)

        case .bottom:
            button.addGestureRecognizer(swipeDownGestureRecognizer)
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

        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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

    public func showMessageView() {
        switch model.origin {
        case .top:
            showAnimate { [weak self] in
                guard let self = self else { return }

                self.center.y += self.bounds.height + self.model.topSpacing
                self.layoutIfNeeded()
            }

        case .bottom:
            showAnimate { [weak self] in
                guard let self = self else { return }

                self.center.y -= self.bounds.height + self.model.bottomSpacing
                self.layoutIfNeeded()
            }
        }

        isHidden = false
    }

    private func showAnimate(animations: @escaping VoidCallback) {
        UIView.animate(
            withDuration: model.animationDuration,
            delay: 0,
            options: model.animationOptions,
            animations: {
                animations()
            },
            completion: nil
        )
    }

    public func hideMessageView() {
        switch model.origin {
        case .top:
            hideAnimation(
                animations: { [weak self] in
                    guard let self = self else { return }

                    self.center.y -= self.bounds.height + self.model.topSpacing
                    self.layoutIfNeeded()
                },
                completion: { [weak self] in
                    guard let self = self else { return }

                    self.isHidden = true
                    self.model.action?()
                }
            )

        case .bottom:
            hideAnimation(
                animations: { [weak self] in
                    guard let self = self else { return }

                    self.center.y += self.bounds.height + self.model.bottomSpacing
                    self.layoutIfNeeded()
                },
                completion: { [weak self] in
                    guard let self = self else { return }

                    self.isHidden = true
                    self.model.action?()
                }
            )
        }
    }

    private func hideAnimation(animations: @escaping VoidCallback, completion: @escaping VoidCallback) {
        UIView.animate(
            withDuration: model.animationDuration,
            delay: 0,
            options: model.animationOptions,
            animations: {
                animations()
            },
            completion: { _ in
                completion()
            }
        )
    }
}
