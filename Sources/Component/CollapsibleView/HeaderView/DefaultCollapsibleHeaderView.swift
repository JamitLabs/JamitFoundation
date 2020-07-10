//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

/// A stateful default header view for the collapsible view.
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
/// ```
public final class DefaultCollapsibleHeaderView: StatefulView<DefaultCollapsibleHeaderViewModel> {
    private lazy var titleLabel: UILabel = .init()

    private lazy var arrowImageView: UIImageView = .init()
    private var arrowImageViewWidthConstraint: NSLayoutConstraint?
    private var arrowImageViewHeightConstraint: NSLayoutConstraint?

    public override func viewDidLoad() {
        super.viewDidLoad()

        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowImageView)
        arrowImageViewWidthConstraint = arrowImageView.widthAnchor.constraint(equalToConstant: 36.0)
        arrowImageViewWidthConstraint?.isActive = true
        arrowImageViewHeightConstraint = arrowImageView.heightAnchor.constraint(equalToConstant: 36.0)
        arrowImageViewHeightConstraint?.isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }

    public override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
        titleLabel.font = model.titleFont

        arrowImageView.image = model.arrowImageUp
        arrowImageViewWidthConstraint?.constant = model.arrowImageViewSizeConstant
        arrowImageViewHeightConstraint?.constant = model.arrowImageViewSizeConstant
    }
}

extension DefaultCollapsibleHeaderView: CollapsibleHeaderViewDelegate {
    public func didChangeCollapsibleState(to isCollapsed: Bool) {
        UIView.animate(withDuration: model.arrowAnimationDuration) { [weak self] in
            guard let self = self else { return }

            let xValue: CGFloat = isCollapsed ? 0.0: 1.0
            self.arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), xValue, 0.0, 0.0)
        }
    }
}
