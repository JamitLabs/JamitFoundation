import Foundation
import UIKit

/// A container class enabling the possibility to embed views conforming to `StatefulViewProtocol`
/// into a `UITableViewController` as reusable headerFooterView.
///
/// Example:
///
/// ```swift
/// // Defined some where in the code base...
/// final class MyView: StatefulView<MyViewModel> {
///     // ...
/// }
///
/// // Making `MyView` embeddable as reusable table view headerFooterView...
/// final class MyHeaderFooterView: ContainerTableViewHeaderFooterView<MyView> {}
/// ```
open class ContainerTableViewHeaderFooterView<ContentView: StatefulViewProtocol>: TableViewHeaderFooterView {
    /// A flag controlling the dynamic resizing behaviour of the embedded view.
    ///
    /// If `isDynamicallyResizable` returns true, then the `view` will be resizable without breaking constraints.
    class var isDynamicallyResizable: Bool { return false }

    /// The underlying view which is embedded into the `contentView`.
    private(set) lazy var view: ContentView = .instantiate()

    private lazy var topConstraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor)
    private lazy var leadingConstraint: NSLayoutConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    private lazy var trailingConstraint: NSLayoutConstraint = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    private lazy var bottomConstraint: NSLayoutConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

    /// The current state of the underlying view.
    public var model: ContentView.Model {
        get { return view.model }
        set {
            view.model = newValue
            perform(#selector(didChangeModel))
        }
    }

    /// The custom disance that the contentView is inset from the background view.
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            topConstraint.constant = contentInset.top
            leadingConstraint.constant = contentInset.left
            trailingConstraint.constant = contentInset.right
            bottomConstraint.constant = contentInset.bottom
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        defaultInit()
        perform(#selector(viewDidLoad))
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        defaultInit()
    }

    override open func awakeFromNib() {
        super.awakeFromNib()

        perform(#selector(viewDidLoad))
    }

    private func defaultInit() {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)

        // NOTE: Setting the priority of bottomConstraint to low avoids unsatisfiable constraints issues in UITableView
        if type(of: self).isDynamicallyResizable {
            bottomConstraint.priority = .defaultLow
        }

        [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint].forEach { $0.isActive = true }
    }

    override open func prepareForReuse() {
        super.prepareForReuse()

        view.model = .default
        perform(#selector(didChangeModel))
    }
}

