import Foundation
import UIKit

/// A container class enabling the possibility to embed views conforming to `StatefulViewProtocol`
/// into a `UICollectionViewController` as reusable cell.
///
/// Example:
///
/// ```swift
/// // Defined some where in the code base...
/// final class MyView: StatefulView<MyViewModel> {
///     // ...
/// }
///
/// // Making `MyView` embeddable as reusable collection view cell...
/// final class MyCollectionViewCell: ContainerCollectionViewCell<MyView> {}
/// ```
open class ContainerCollectionViewCell<ContentView: StatefulViewProtocol>: CollectionViewCell {
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
            perform(#selector(didChangeModel))
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        defaultInit()
        perform(#selector(viewDidLoad))
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        defaultInit()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        perform(#selector(viewDidLoad))
    }

    private func defaultInit() {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint].forEach { $0.isActive = true }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()

        view.model = .default
        perform(#selector(didChangeModel))
    }
}
