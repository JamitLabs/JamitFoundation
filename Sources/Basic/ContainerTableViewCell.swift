import Foundation
import UIKit

/// A container class enabling the possibility to embed views conforming to `StatefulViewProtocol`
/// into a `UITableViewController` as reusable cell.
///
/// Example:
///
/// ```swift
/// // Defined some where in the code base...
/// final class MyView: StatefulView<MyViewModel> {
///     // ...
/// }
///
/// // Making `MyView` embeddable as reusable table view cell...
/// final class MyTableViewCell: ContainerTableViewCell<MyView> {}
/// ```
open class ContainerTableViewCell<ContentView: StatefulViewProtocol>: UITableViewCell {
    /// A flag controlling the dynamic resizing behaviour of the embedded view.
    ///
    /// If `isDynamicallyResizable` returns true, then the `view` will be resizable without breaking constraints.
    open class var isDynamicallyResizable: Bool { return false }

    /// The underlying view which is embedded into the `contentView`.
    public private(set) lazy var view: ContentView = .instantiate()

    private lazy var topConstraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor)
    private lazy var leadingConstraint: NSLayoutConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    private lazy var trailingConstraint: NSLayoutConstraint = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    private lazy var bottomConstraint: NSLayoutConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

    /// The current state of the underlying view.
    public var model: ContentView.Model {
        get { return view.model }
        set {
            view.model = newValue
            didChangeModel()
        }
    }

    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            topConstraint.constant = contentInsets.top
            leadingConstraint.constant = contentInsets.left
            trailingConstraint.constant = contentInsets.right
            bottomConstraint.constant = contentInsets.bottom
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        defaultInit()
        viewDidLoad()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        defaultInit()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        viewDidLoad()
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

    open override func prepareForReuse() {
        super.prepareForReuse()

        view.model = .default
        didChangeModel()
    }
}

extension ContainerTableViewCell {
    /// This method is intended to be overridden by a subclass to perform setup after the initialization of the cell.
    ///
    /// - Attention: Always ensure calling `super.viewDidLoad()` to avoid unexpected behaviour.
    open func viewDidLoad() {}

    /// This method is intended to be overridden by a subclass to listen for state changes.
    ///
    /// - Attention: Always ensure calling `super.didChangeModel()` to avoid unexpected behaviour.
    open func didChangeModel() {}
}
