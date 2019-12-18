import Foundation
import JamitFoundation
import UIKit

/// A stateful view which presents a collection of `ItemView`s in a grid based layout.
///
/// Example:
/// ```swift
/// // GridView instantiation with an image view listening to touch events
/// let gridView: GridView<ActionView<ImageView>> = .instantiate()
///
/// // GridView model update
/// let imageSourceURLs: [URL] = <#image sources#>
/// gridView.model = GridViewModel(
///     insets: .zero,
///     spacing: .zero,
///     numberOfColumns: 3,
///     items: imageSourceURLs.map { imageSourceURL in
///         return ActionViewModel(content: .url(imageSourceURL)) { [unowned self] in
///             print("Did tap image view with url: \(imageSourceURL)")
///         }
///     }
/// )
/// ```
public final class GridView<ItemView: StatefulViewProtocol>: StatefulView<GridViewModel<ItemView.Model>>,
    UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private final class ItemViewCell: ContainerCollectionViewCell<ItemView> {}

    private lazy var collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: collectionViewLayout)

    /// A flag controlling the scroll behaviour of the underlying content view.
    ///
    /// If `isScrollEnabled` is true then the content of the `GridView` can scroll on the vertical axis.
    public var isScrollEnabled: Bool {
        get { collectionView.isScrollEnabled }
        set { collectionView.isScrollEnabled = newValue }
    }

    /// A size indicating the natural size for the receiving view based on its intrinsic properties.
    public override var intrinsicContentSize: CGSize {
        return collectionView.contentSize
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        collectionView.clipsToBounds = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.register(cellOfType: ItemViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    public override func didChangeModel() {
        super.didChangeModel()

        collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        invalidateIntrinsicContentSize()
    }

    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellOfType: ItemViewCell.self, for: indexPath)
        cell.model = model.items[indexPath.item]
        return cell
    }

    // MARK: - UICollectionViewDelegate

    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let bounds = collectionView.bounds.inset(by: model.insets)
        let totalColumnSpacing = model.spacing.width * CGFloat(max(0, model.numberOfColumns - 1))
        let width = (bounds.width - totalColumnSpacing) / CGFloat(max(1, model.numberOfColumns))

        return CGSize(width: width, height: width)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return model.insets
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return model.spacing.height
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return model.spacing.width
    }
}
