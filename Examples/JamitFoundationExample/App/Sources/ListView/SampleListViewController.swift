//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class SampleListViewController: ListViewController<ListItemView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ListViewController"
        
        model = .init(
            height: .constant(60),
            items: [
                .init(title: NSLocalizedString("SAMPLE_LIST_VIEW_CONTROLLER.TABLE_VIEW_ITEM.TITLE", comment: "")),
                .init(title: NSLocalizedString("SAMPLE_LIST_VIEW_CONTROLLER.ACTION_VIEW_ITEM.TITLE", comment: "")),
                .init(title: NSLocalizedString("SAMPLE_LIST_VIEW_CONTROLLER.SCROLL_VIEW_ITEM.TITLE", comment: ""))
            ]
        )

        tableView.separatorStyle = .none
        tableView.delegate = self
    }

    private func showTableView() {
        let viewController: TableViewController = .instantiate()
        viewController.model = .init(
            items: [
                .title(.init(title: NSLocalizedString("TABLE_VIEW_CONTROLLER.FIRST_SECTION.TITLE", comment: ""))),
                .item(
                    .init(
                        imageURL: URL(string: "https://picsum.photos/id/233/200/300"),
                        details: NSLocalizedString("TABLE_VIEW_CONTROLLER.FIRST_SECTION.FIRST_ITEM.DETAILS", comment: "")
                    )
                ),
                .item(
                    .init(
                        imageURL: URL(string: "https://picsum.photos/id/234/300/200"),
                        details: NSLocalizedString("TABLE_VIEW_CONTROLLER.FIRST_SECTION.SECOND_ITEM.DETAILS", comment: "")
                    )
                ),
                .title(.init(title: NSLocalizedString("TABLE_VIEW_CONTROLLER.SECOND_SECTION.TITLE", comment: ""))),
                .item(
                    .init(
                        imageURL: URL(string: "https://picsum.photos/id/235/300/200"),
                        details: NSLocalizedString("TABLE_VIEW_CONTROLLER.SECOND_SECTION.FIRST_ITEM.DETAILS", comment: "")
                    )
                )
            ]
        )
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showActionView() {
        let viewController = ActionViewController.instantiate()
        viewController.model = .init(
            imageURL: URL(string: "https://picsum.photos/id/235/300/200")
        )
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showScrollView() {
        let viewController = MyScrollViewController.instantiate()
        viewController.model = .init(
            text: NSLocalizedString("SCROLL_VIEW_CONTROLLER.CONTENT", comment: "")
        )
        let scrollViewController = ScrollViewController(contentViewController: viewController)
        navigationController?.pushViewController(scrollViewController, animated: true)
    }
}

extension SampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showTableView()

        case 1:
            showActionView()

        case 2:
            showScrollView()

        default:
            break
        }
    }
}
