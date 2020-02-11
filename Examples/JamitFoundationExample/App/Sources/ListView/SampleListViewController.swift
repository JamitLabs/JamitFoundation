//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class SampleListViewController: ListViewController<ListItemView> {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        title = "ListViewController"

        model = ListViewModel.init(
            height: .constant(60),
            items: [
                ListItemViewModel(title: "TableView")
            ]
        )

        tableView.separatorStyle = .none
        tableView.delegate = self
    }

    private func showTableView() {
        let viewController = TableViewController.instantiate()
        viewController.model = .init(
            items: [
                .title(.init(title: "Section Header"))
            ]
        )
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTableView()
    }
}
