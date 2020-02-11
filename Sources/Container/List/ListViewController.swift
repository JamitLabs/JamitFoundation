import Foundation
import UIKit

/// A container view controller which displays a list of views in a table view of type `View`.
///
/// This can be preferred to be used instead of a `UITableViewController` if there is only a
/// single distinct row type in the list.
///
/// Example:
/// ```swift
/// // A stateful view defined some where in the code base...
/// final class FruitView: StatefulView<FruitViewModel> {
///     // ...
/// }
///
/// // The specialization of a list view for `FruitView`...
/// final class FruitListViewController: ListViewController<FruitView> {
///     // ...
/// }
///
/// // Instantiation and data population...
/// let fruitListViewController: FruitListViewController = .instantiate()
/// fruitListViewController.model = .init(items: [FruitViewModel(...), ...])
/// ```
open class ListViewController<View: StatefulViewProtocol>: StatefulViewController<ListViewModel<View.Model>>, UITableViewDataSource {
    private final class ListTableViewCell: ContainerTableViewCell<View> {}

    /// The content table view of the `ListViewController`.
    public private(set) lazy var tableView: UITableView = .init(frame: .zero, style: .plain)

    public override func loadView() {
        view = tableView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(cellOfType: ListTableViewCell.self)
    }

    public override func didChangeModel() {
        super.didChangeModel()

        switch model.height {
        case let .constant(rowHeight):
            tableView.rowHeight = rowHeight
            tableView.estimatedRowHeight = 0

        case let .dynamic(estimatedRowHeight):
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = estimatedRowHeight ?? .leastNonzeroMagnitude
        }

        tableView.reloadData()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellOfType: ListTableViewCell.self, for: indexPath)
        cell.model = model.items[indexPath.row]
        return cell
    }
}
