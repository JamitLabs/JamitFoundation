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
                .init(title: NSLocalizedString("SAMPLE_LIST_VIEW_CONTROLLER.SCROLL_VIEW_ITEM.TITLE", comment: "")),
                .init(title: NSLocalizedString("SAMPLE_LIST_VIEW_CONTROLLER.COLLAPSIBLE_VIEW_ITEM.TITLE", comment: "")),
                .init(title: NSLocalizedString("SAMPLE_LIST_VIEW_CONTROLLER.COLLECTION_VIEW_ITEM.TITLE", comment: ""))
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
    
    private func showCollapsibleView() {
        let viewController: CollapsibleViewController = .instantiate()
        viewController.model = .init(
            headerTitles: [
                NSLocalizedString("COLLAPSIBLE_VIEW.FIRST_HEADER.TITLE", comment: ""),
                NSLocalizedString("COLLAPSIBLE_VIEW.SECOND_HEADER.TITLE", comment: "")
            ],
            headerViewHeightConstant: 60.0,
            headerTitleFont: .systemFont(ofSize: 16.0),
            headerArrowImage: UIImage(named: "icArrowUp")
        )
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func showCollectionView() {
        let viewController: SampleCollectionViewController = .instantiate()

        let itemNumber = 40
        let itemBackgroundColor: UIColor = .cyan
        let opacityFactor: CGFloat = 1 / CGFloat(itemNumber)
        let items: [SampleCollectionViewItemModel] = (0..<itemNumber).map { index in
            let opacity: CGFloat = 1 - (CGFloat(index) * opacityFactor)
            return .init(backgroundColor: itemBackgroundColor.withAlphaComponent(opacity))
        }

        viewController.model = .init(
            header: .init(
                title: "Header".uppercased(),
                backgroundColor: UIColor.yellow.withAlphaComponent(0.2)
            ),
            footer: .init(
                title: "Footer".uppercased(),
                backgroundColor: UIColor.yellow.withAlphaComponent(0.1)
            ),
            items: items
        )
        navigationController?.pushViewController(viewController, animated: true)
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

        case 3:
            showCollapsibleView()

        case 4:
            showCollectionView()

        default:
            break
        }
    }
}
