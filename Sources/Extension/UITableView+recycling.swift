import Foundation
import UIKit

public extension UITableView {
    /// Registers a reusable table view cell of type `CellType` which inherits from `UITableViewCell`.
    ///
    /// The reusable cell will be registered as nib when there is a nib file inside the given Bundle
    /// which has the same name as the class name of `CellType`.
    ///
    /// The reuse identifier of the cell will be the class name of `CellType`.
    ///
    /// Example:
    ///
    /// ```swift
    /// tableView.register(cellOfType: MyCellType.self)
    /// tableView.register(cellOfType: MyOtherCellType.self)
    /// ```
    /// 
    /// - Parameter cellType: The type of the reusable cell to register.
    func register<CellType: UITableViewCell>(cellOfType cellType: CellType.Type) {
        let identifier = String(describing: cellType)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: .main), forCellReuseIdentifier: identifier)
        } else {
            register(cellType, forCellReuseIdentifier: identifier)
        }
    }

    /// Registers a reusable table view headerFooterView of type `HeaderFooterViewType` which inherits from `UITableViewHeaderFooterView`.
    ///
    /// The reusable headerFooterView will be registered as nib when there is a nib file inside the given Bundle
    /// which has the same name as the class name of `HeaderFooterViewType`.
    ///
    /// The reuse identifier of the headerFooterView will be the class name of `HeaderFooterViewType`.
    ///
    /// Example:
    ///
    /// ```swift
    /// tableView.register(headerFooterViewOfType: MyHeaderFooterView.self)
    /// ```
    ///
    /// - Parameter headerFooterViewOfType: The type of the reusable headerFooterView to register.
    func register<HeaderFooterViewType: UITableViewHeaderFooterView>(headerFooterViewOfType headerFooterViewType: HeaderFooterViewType.Type) {
        let identifier = String(describing: headerFooterViewType)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: .main), forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(headerFooterViewType, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }

    /// Dequeues a reusable table view cell of type `CellType` which inherits from `UITableViewCell`.
    ///
    /// The class name of the `CellType` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// // The type of `cell` will be `MyCellType`.
    /// let cell = tableView.dequeue(cellOfType: MyCellType.self)
    /// ```
    ///
    /// - Attention: Always ensure that the registered cell is of type `CellType`
    ///              when the cell is not of type `CellType` a crash will occure at runtime.
    ///
    /// - Parameter cellType: The reusable cell type to be dequeued.
    /// - Parameter indexPath: The index path for which the dequeue is intented to be.
    func dequeue<Cell: UITableViewCell>(cellOfType cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }

    /// Dequeues a reusable table view headerFooterView of type `HeaderFooterView` which inherits from `UITableViewHeaderFooterView`.
    ///
    /// The class name of the `HeaderFooterView` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// // The type of `headerFooterview` will be `MyHeaderFooterView`.
    /// let headerFooter = tableView.dequeue(headerFooterViewOfType: MyHeaderFooterView.self)
    /// ```
    ///
    /// - Attention: Always ensure that the registered headerFooterView is of type `HeaderFooterView`
    ///              when the cell is not of type `HeaderFooterView` a crash will occure at runtime.
    ///
    /// - Parameter headerFooterViewType: The reusable headerFooterView type to be dequeued.
    func dequeue<HeaderFooterView: UITableViewHeaderFooterView>(headerFooterViewOfType headerFooterViewType: HeaderFooterView.Type) -> HeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: headerFooterViewType)) as! HeaderFooterView
    }
}

public extension UITableView {
    /// Dequeues a reusable table view cell of type `CellType` which inherits from `UITableViewCell`.
    ///
    /// The class name of the `CellType` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// let cell = tableView.dequeue(cellOfType: MyCellType.self) { cell, indexPath, in
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
    func dequeue<Cell: UITableViewCell>(
        cellOfType cellType: Cell.Type,
        for indexPath: IndexPath,
        _ setup: (Cell, IndexPath) -> Void
    ) -> Cell {
        let cell = dequeue(cellOfType: cellType, for: indexPath)
        setup(cell, indexPath)
        return cell
    }

    /// Dequeues a reusable table view cell of type `CellType` which inherits from `ContainerTableViewCell`.
    ///
    /// The class name of the `CellType` will be used as reuse identifier of the dequeued cell.
    ///
    /// Example:
    /// ```swift
    /// let cell = tableView.dequeue(cellOfType: MyStatefulCellType.self) { cell, indexPath, in
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
    func dequeue<View: StatefulViewProtocol, Cell: ContainerTableViewCell<View>>(
        cellOfType cellType: Cell.Type,
        for indexPath: IndexPath,
        _ buildModel: (IndexPath) -> View.Model
    ) -> Cell {
        let cell = dequeue(cellOfType: cellType, for: indexPath)
        cell.model = buildModel(indexPath)
        return cell
    }
}
