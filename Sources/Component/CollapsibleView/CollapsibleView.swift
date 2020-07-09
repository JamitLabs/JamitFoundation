//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

/// Protocol a header view should conform to to be informed about certain changes
public protocol CollapsibleHeaderViewDelegate {
    /// Called when the state of the collapsible view has changed.
    ///
    ///- Parameter to: The current state of the collapsible view..
    func didChangeCollapsibleState(to isCollapsed: Bool)
}

/// A stateful collapsible view.
///
/// Example:
/// ```swift
/// let defaultCollapsibleHeaderView: DefaultCollapsibleHeaderView = .init()
/// defaultCollapsibleHeaderView.model = .init(
///     title: "Header title",
///     titleFont: .systemFont(ofSize: 16.0),
///     arrowImageUp: nil // TODO: Place an image here if needed
/// )
/// // TODO: adjust height of your header view.
/// defaultCollapsibleHeaderView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
///
/// let view: UIView = .init()
/// view.backgroundColor = .red
/// view.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
/// view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
///
/// collapsibleView.model = CollapsibleViewModel(
///     headerView: defaultCollapsibleHeaderView,
///     items: [view],
///     isCollapsed: true
/// )
/// ```
public final class CollapsibleView: StatefulView<CollapsibleViewModel> {
    private lazy var headerViewContainer: UIView = .init()

    private lazy var actionButton: UIButton = {
        let actionButton: UIButton = .init()
        actionButton.setTitle("", for: .normal)
        actionButton.addTarget(self, action: #selector(didTriggerAction), for: .primaryActionTriggered)
        actionButton.addTarget(self, action: #selector(updateBackgroundColor), for: .allTouchEvents)
        actionButton.addTarget(self, action: #selector(lateUpdateBackgroundColor), for: .allTouchEvents)
        return actionButton
    }()

    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        headerViewContainer.backgroundColor = .white
        headerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerViewContainer)
        headerViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        actionButton.topAnchor.constraint(equalTo: headerViewContainer.topAnchor).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: headerViewContainer.leadingAnchor).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: headerViewContainer.trailingAnchor).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: headerViewContainer.bottomAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    public override func didChangeModel() {
        super.didChangeModel()

        model.headerView.translatesAutoresizingMaskIntoConstraints = false
        headerViewContainer.addSubview(model.headerView)
        model.headerView.topAnchor.constraint(equalTo: headerViewContainer.topAnchor).isActive = true
        model.headerView.leadingAnchor.constraint(equalTo: headerViewContainer.leadingAnchor).isActive = true
        model.headerView.trailingAnchor.constraint(equalTo: headerViewContainer.trailingAnchor).isActive = true
        model.headerView.bottomAnchor.constraint(equalTo: headerViewContainer.bottomAnchor).isActive = true

        if (stackView.arrangedSubviews.count != model.items.count) {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            model.items.forEach { view in
                view.isHidden = !model.isCollapsed
                stackView.addArrangedSubview(view)
            }
        } else {
            UIView.animate(withDuration: model.animationDuration) {
                self.model.items.forEach { view in
                    view.isHidden = !self.model.isCollapsed
                }
            }
        }

        guard let headerView = model.headerView as? CollapsibleHeaderViewDelegate else { return }

        headerView.didChangeCollapsibleState(to: model.isCollapsed)
    }

    @objc
    private func didTriggerAction() {
        model.isCollapsed.toggle()
    }

    @objc
    private func updateBackgroundColor() {
        if [.highlighted, .selected].contains(actionButton.state) {
            actionButton.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        } else {
            actionButton.backgroundColor = UIColor.black.withAlphaComponent(0)
        }
    }

    @objc
    private func lateUpdateBackgroundColor() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.updateBackgroundColor()
        }
    }
}
