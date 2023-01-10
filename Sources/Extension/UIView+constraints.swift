//  Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import UIKit

extension UIView {
    /// Centers the view relative to another view and limits its size to the its edges
    public func center(in otherView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        centerXAnchor.constraint(equalTo: otherView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: otherView.centerYAnchor).isActive = true
    }

    /// Centers the view relative to another view and limits its size to the its edges
    public func centerInParent() {
        guard let parent = superview else { return }

        center(in: parent)
    }

    /// Extends the view to another view edges
    public func constraintEdges(
        to otherView: UIView,
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: otherView.topAnchor, constant: insets.top).withPriority(priority).isActive = true
        rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: -insets.right).withPriority(priority).isActive = true
        bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: -insets.bottom).withPriority(priority).isActive = true
        leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: insets.left).withPriority(priority).isActive = true
    }

    /// Extends the view to the parents edges
    public func constraintEdgesToParent(
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) {
        guard let parent = superview else { return }

        constraintEdges(to: parent, insets: insets, priority: priority)
    }

    /// Centers the view relative to parent view and limits its size to its edges
    public func constraintEdgesToParentAndCenter() {
        guard let parent = superview else { return }

        constraintEdgesToParent(priority: .defaultHigh)
        centerInParent()

        topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor).isActive = true
        rightAnchor.constraint(lessThanOrEqualTo: parent.rightAnchor).isActive = true
        bottomAnchor.constraint(lessThanOrEqualTo: parent.bottomAnchor).isActive = true
        leftAnchor.constraint(greaterThanOrEqualTo: parent.leftAnchor).isActive = true
    }
}
