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
///
/// let itemView: UIView = .init()
/// itemView.backgroundColor = .red
/// itemView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
/// itemView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
///
/// collapsibleView.model = .init(
///     headerViewModel: .init(
///         title: "Header title",
///         titleFont: .systemFont(ofSize: 16.0),
///         arrowImageUp: nil // TODO: Place an image here if needed
///     ),
///     items: [itemView],
///     isCollapsed: true,
///     animationDuration: 0.3
/// )
/// ```
public final class CollapsibleView<HeaderView: StatefulViewProtocol>: StatefulView<CollapsibleViewModel<HeaderView.Model>> {
    private lazy var headerView: HeaderView = .instantiate()

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
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        clipsToBounds = true
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        actionButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    public override func didChangeModel() {
        super.didChangeModel()

        headerView.model = model.headerViewModel

        if (stackView.arrangedSubviews.count != model.items.count) {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            model.items.forEach { view in
                view.isHidden = model.isCollapsed
                stackView.addArrangedSubview(view)
            }
        } else {
            UIView.animate(withDuration: model.animationDuration) {
                self.model.items.forEach { view in
                    view.isHidden = self.model.isCollapsed
                }
            }
        }

        (headerView as? CollapsibleHeaderViewDelegate)?.didChangeCollapsibleState(to: model.isCollapsed)
    }

    @objc
    private func didTriggerAction() {
        model.isCollapsed.toggle()
        model.didChangeCollapsibleState?(model.isCollapsed)
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
