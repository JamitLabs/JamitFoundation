//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

class TableViewController: StatefulViewController<TableViewViewModel> {
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TableViewController"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.register(cellOfType: TableViewTitleTableViewCell.self)
        tableView.register(cellOfType: TableViewItemTableViewCell.self)
        tableView.register(cellOfType: CollapsibleTableViewCell.self)
    }

    override func didChangeModel() {
        super.didChangeModel()

        let visibleIndexPaths = tableView.indexPathsForVisibleRows ?? []
        guard !visibleIndexPaths.isEmpty else {
            tableView.reloadData()
            return
        }

        tableView.beginUpdates()
        // TODO: Check if necessary
//        visibleIndexPaths.forEach { indexPath in
//            guard
//                let cell = tableView.visibleCells[indexPath.row] as? CollapsibleTableViewCell,
//                cell.didChangeState
//            else {
//                return
//            }
//
//            tableView.reloadRows(at: [indexPath], with: .none)
//            cell.didChangeState = false
//        }

        tableView.endUpdates()
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = model.items[indexPath.row]

        switch currentItem {
        case let .title(model):
            let view = tableView.dequeue(cellOfType: TableViewTitleTableViewCell.self, for: indexPath)
            view.model = model
            return view
            
        case let .item(model):
            let view = tableView.dequeue(cellOfType: TableViewItemTableViewCell.self, for: indexPath)
            view.model = model
            return view

        case let .collapsible(model):
            let view = tableView.dequeue(cellOfType: CollapsibleTableViewCell.self, for: indexPath)
            view.model = model
            
            view.model.didChangeCollapsibleState = { isCollapsed in
                guard case let .collapsible(viewModel) = self.model.items[indexPath.row] else { return }

                var newViewModel = viewModel
                newViewModel.isCollapsed = isCollapsed
                self.model.items[indexPath.row] = .collapsible(newViewModel)
                
                view.didChangeState = true
            }
            return view
        }
    }
    
}

extension TableViewController: UITableViewDelegate {
    
}
