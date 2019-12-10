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
