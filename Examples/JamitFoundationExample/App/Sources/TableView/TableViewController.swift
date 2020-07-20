//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

class TableViewController: StatefulViewController<TableViewViewModel> {
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TableViewController"

        tableView.register(cellOfType: TableViewTitleTableViewCell.self)
        tableView.register(cellOfType: TableViewItemTableViewCell.self)
    }

    override func didChangeModel() {
        super.didChangeModel()

        tableView.reloadData()
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
        }
    }
}

extension TableViewController: UITableViewDelegate {
    
}
