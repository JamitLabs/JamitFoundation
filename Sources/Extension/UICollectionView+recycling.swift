import Foundation
import UIKit

public extension UICollectionView {
    /// Registers a reusable collection view cell of type `CellType` which inherits from `UICollectionViewCell`.
    ///
    /// The reusable cell will be registered as nib when there is a nib file inside the given Bundle
    /// which has the same name as the class name of `CellType`.
    ///
    /// The reuse identifier of the cell will be the class name of `CellType`.
    ///
    /// Example:
    ///
    /// ```swift
    /// collectionView.register(cellOfType: MyCellType.self)
    /// collectionView.register(cellOfType: MyOtherCellType.self)
    /// ```
    ///
    /// - Parameter cellType: The type of the reusable cell to register.
    func register<CellType: UICollectionViewCell>(cellOfType cellType: CellType.Type) {
        let identifier = String(describing: cellType)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: .main), forCellWithReuseIdentifier: identifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: identifier)
        }
    }

    /// Dequeues a reusable collection view cell of type `CellType` which inherits from `UICollectionViewCell`.
    ///
    /// The class name of the `CellType` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// // The type of `cell` will be `MyCellType`.
    /// let cell = collectionView.dequeue(cellOfType: MyCellType.self)
    /// ```
    ///
    /// - Attention: Always ensure that the registered cell is of type `CellType`
    ///              when the cell is not of type `CellType` a crash will occure at runtime.
    ///
    /// - Parameter cellType: The reusable cell type to be dequeued.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    func dequeue<Cell: UICollectionViewCell>(cellOfType cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
}

public extension UICollectionView {
    /// Dequeues a reusable collection view cell of type `CellType` which inherits from `UICollectionViewCell`.
    ///
    /// The class name of the `CellType` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// let cell = collectionView.dequeue(cellOfType: MyCellType.self) { cell, indexPath, in
    ///     cell.aMember = myDataLookupArray[indexPath.row]
    /// }
    /// ```
    ///
    /// - Attention: Always ensure that the registered cell is of type `CellType`
    ///              when the cell is not of type `CellType` a crash will occure at runtime.
    ///
    /// - Parameter cellType: The reusable cell type to be dequeued.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    /// - Parameter setup: A closure called after the dequeuing of the reusable cell.
    func dequeue<Cell: UICollectionViewCell>(
        cellOfType cellType: Cell.Type,
        for indexPath: IndexPath,
        _ setup: (Cell, IndexPath) -> Void
    ) -> Cell {
        let cell = dequeue(cellOfType: cellType, for: indexPath)
        setup(cell, indexPath)
        return cell
    }

    /// Dequeues a reusable collection view cell of type `CellType` which inherits from `ContainerCollectionViewCell`.
    ///
    /// The class name of the `CellType` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// let cell = collectionView.dequeue(cellOfType: MyStatefulCellType.self) { cell, indexPath, in
    ///     return MyStatefulViewModel(title: "Hello World")
    /// }
    /// ```
    ///
    /// - Attention: Always ensure that the registered cell is of type `CellType`
    ///              when the cell is not of type `CellType` a crash will occure at runtime.
    ///
    /// - Parameter cellType: The reusable cell type to be dequeued.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    /// - Parameter buildModel: A closure called after the dequeuing of the reusable cell assigning the `model` of the instance.
    func dequeue<View: StatefulViewProtocol, Cell: ContainerCollectionViewCell<View>>(
        cellOfType cellType: Cell.Type,
        for indexPath: IndexPath,
        _ buildModel: (IndexPath) -> View.Model
    ) -> Cell {
        let cell = dequeue(cellOfType: cellType, for: indexPath)
        cell.model = buildModel(indexPath)
        return cell
    }
}

public extension UICollectionView {
    /// Registers a reusable header view of type `ReusableViewType` which inherits from `UICollectionReusableView`.
    ///
    /// The reusable view will be registered as nib when there is a nib file inside the given Bundle
    /// which has the same name as the class name of `CollectionReusableView`.
    ///
    /// The reuse identifier of the reusable view will be the class name of `CollectionReusableView`.
    ///
    /// - Parameter reuseableViewType: The type of reusable view to retrieve.
    func register<CollectionReusableView: UICollectionReusableView>(
        reusableHeaderWithType reuseableViewType: CollectionReusableView.Type
    ) {
        register(reusableViewWithType: reuseableViewType, ofKind: Self.elementKindSectionHeader)
    }

    /// Registers a reusable footer view of type `ReusableViewType` which inherits from `UICollectionReusableView`.
    ///
    /// The reusable view will be registered as nib when there is a nib file inside the given Bundle
    /// which has the same name as the class name of `CollectionReusableView`.
    ///
    /// The reuse identifier of the reusable view will be the class name of `CollectionReusableView`.
    ///
    /// - Parameter reuseableViewType: The type of reusable view to retrieve.
    func register<CollectionReusableView: UICollectionReusableView>(
        reusableFooterWithType reuseableViewType: CollectionReusableView.Type
    ) {
        register(reusableViewWithType: reuseableViewType, ofKind: Self.elementKindSectionFooter)
    }

    /// Registers a reusable view of type `ReusableViewType` which inherits from `UICollectionReusableView`.
    ///
    /// The reusable view will be registered as nib when there is a nib file inside the given Bundle
    /// which has the same name as the class name of `CollectionReusableView`.
    ///
    /// The reuse identifier of the reusable view will be the class name of `CollectionReusableView`.
    ///
    /// Example:
    ///
    /// ```swift
    /// collectionView.register(reusableViewWithType: MySectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
    /// collectionView.register(reusableViewWithType: MySectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    /// ```
    ///
    /// - Parameter reuseableViewType: The type of reusable view to retrieve.
    /// - Parameter reusableViewKind: The kind of supplementary view to retrieve.
    func register<CollectionReusableView: UICollectionReusableView>(
        reusableViewWithType reusableViewType: CollectionReusableView.Type,
        ofKind reusableViewKind: String
    ) {
        let identifier = String(describing: reusableViewType)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(
                UINib(nibName: identifier, bundle: .main),
                forSupplementaryViewOfKind: reusableViewKind,
                withReuseIdentifier: identifier
            )
        } else {
            register(
                reusableViewType,
                forSupplementaryViewOfKind: reusableViewKind,
                withReuseIdentifier: identifier
            )
        }
    }

    /// Dequeues a reusable header view of type `CollectionReusableView` which inherits from `UICollectionReusableView`.
    ///
    /// The class name of the `CollectionReusableView` will be used as identifier of the reusable view.
    ///
    /// Example:
    ///
    /// ```swift
    /// // The type of `reusableHeaderView` will be `MyReusableHeaderView`.
    /// let reusableHeaderView = collectionView.dequeue(reusableHeaderWithType: MyReusableHeaderView.self)
    /// ```
    ///
    /// - Attention: Always ensure that the registered reusable view is of type `CollectionReusableView`,
    ///              otherwise a crash will occur at runtime.
    ///
    /// - Parameter reuseableViewType: The type of reusable view to retrieve.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    func dequeue<CollectionReusableView: UICollectionReusableView>(
        reusableHeaderWithType reuseableViewType: CollectionReusableView.Type,
        for indexPath: IndexPath
    ) -> CollectionReusableView {
        return dequeue(reusableViewType: reuseableViewType, ofKind: Self.elementKindSectionHeader, for: indexPath)
    }

    /// Dequeues a reusable footer view of type `CollectionReusableView` which inherits from `UICollectionReusableView`.
    ///
    /// The class name of the `CollectionReusableView` will be used as identifier of the reusable view.
    ///
    /// Example:
    ///
    /// ```swift
    /// // The type of `reusableFooterView` will be `MyReusableFooterView`.
    /// let reusableFooterView = collectionView.dequeue(reusableFooterWithType: MyReusableFooterView.self)
    /// ```
    ///
    /// - Attention: Always ensure that the registered reusable view is of type `CollectionReusableView`,
    ///              otherwise a crash will occur at runtime.
    ///
    /// - Parameter reuseableViewType: The type of reusable view to retrieve.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    func dequeue<CollectionReusableView: UICollectionReusableView>(
        reusableFooterWithType reuseableViewType: CollectionReusableView.Type,
        for indexPath: IndexPath
    ) -> CollectionReusableView {
        return dequeue(reusableViewType: reuseableViewType, ofKind: Self.elementKindSectionFooter, for: indexPath)
    }

    /// Dequeues a reusable header view of type `CollectionReusableView` which inherits from `UICollectionReusableView`.
    ///
    /// The class name of the `CollectionReusableView` will be used as identifier of the reusable view.
    ///
    /// - Attention: Always ensure that the registered reusable view is of type `CollectionReusableView`
    ///              when the view is not of type `CollectionReusableView` a crash will occur at runtime.
    ///
    /// - Parameter reuseableViewType: The type of reusable view to retrieve.
    /// - Parameter reusableViewKind: The kind of supplementary view to retrieve.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    func dequeue<CollectionReusableView: UICollectionReusableView>(
        reusableViewType: CollectionReusableView.Type,
        ofKind reusableViewKind: String,
        for indexPath: IndexPath
    ) -> CollectionReusableView {
        return dequeueReusableSupplementaryView(
            ofKind: reusableViewKind,
            withReuseIdentifier: String(describing: reusableViewType),
            for: indexPath
        ) as! CollectionReusableView
    }
}
