import Foundation
import UIKit

/// A container class enabling the possibility to embed views conforming to `StatefulViewProtocol`
/// into a `UICollectionViewController` as reusable views.
///
/// Example:
///
/// ```swift
/// // Defined somewhere in the code base...
/// final class MyView: StatefulView<MyViewModel> {
///     // ...
/// }
///
/// // Making `MyView` embeddable as reusable supplementary view...
/// final class MyCollectionSupplementaryView: ContainerCollectionReusableView<MyView> {}
/// ```
class ContainerCollectionReusableView<ContentView: StatefulViewProtocol>: CollectionReusableView {
    /// The underlying view which is embedded into the `contentView`.
    public private(set) lazy var contentView: ContentView = .instantiate()

    /// The current state of the underlying view.
    public var model: ContentView.Model {
        get { return contentView.model }
        set {
            contentView.model = newValue
            perform(#selector(didChangeModel))
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

    private lazy var topConstraint: NSLayoutConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
    private lazy var leadingConstraint: NSLayoutConstraint = contentView.leadingAnchor.constraint(equalTo: leadingAnchor)
    private lazy var trailingConstraint: NSLayoutConstraint = trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    private lazy var bottomConstraint: NSLayoutConstraint = bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }

    open override func prepareForReuse() {
        super.prepareForReuse()

        contentView.model = .default
        perform(#selector(didChangeModel))
    }
}
