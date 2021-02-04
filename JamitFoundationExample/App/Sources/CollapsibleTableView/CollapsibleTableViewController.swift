//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class CollapsibleTableViewController: StatefulViewController<CollapsibleTableViewControllerViewModel> {
    @IBOutlet private var contentView: UIView!

    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellOfType: CollapsibleTableViewCell<DefaultCollapsibleHeaderView>.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CollapsibleTableViewController"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        let visibleIndexPaths = tableView.indexPathsForVisibleRows ?? []
        guard !visibleIndexPaths.isEmpty else {
            tableView.reloadData()
            return
        }

        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension CollapsibleTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = model.items[indexPath.row]

        switch currentItem {
        case let .collapsible(model):
            let view = tableView.dequeue(cellOfType: CollapsibleTableViewCell<DefaultCollapsibleHeaderView>.self, for: indexPath)
            view.model = model

            view.model.didChangeCollapsibleState = { isCollapsed in
                guard case let .collapsible(viewModel) = self.model.items[indexPath.row] else { return }

                var newViewModel = viewModel
                newViewModel.isCollapsed = isCollapsed
                self.model.items[indexPath.row] = .collapsible(newViewModel)
            }

            return view
        }
    }
}
