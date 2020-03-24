//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class SampleListViewController: ListViewController<ListItemView> {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ListViewController"

        model = ListViewModel.init(
            height: .constant(60),
            items: [
                ListItemViewModel(title: "TableView"),
                ListItemViewModel(title: "ActionView")
            ]
        )

        tableView.separatorStyle = .none
        tableView.delegate = self
    }

    private func showTableView() {
        let viewController = TableViewController.instantiate()
        viewController.model = .init(
            items: [
                .title(.init(title: "Lorem ipsum")),
                .item(.init(
                    imageURL: URL(string: "https://picsum.photos/id/233/200/300"),
                    description: "Lorem ipsum dolor sit amet consectetur adipiscing elit, urna consequat felis vehicula class ultricies mollis dictumst, aenean non a in donec nulla."
                    )
                ),
                .item(.init(
                    imageURL: URL(string: "https://picsum.photos/id/234/300/200"),
                    description: "Phasellus ante pellentesque erat cum risus consequat imperdiet aliquam, integer placerat et turpis mi eros nec lobortis taciti, vehicula nisl litora tellus ligula porttitor metus."
                    )
                ),
                .title(.init(title: "Vivamus integer")),
                .item(.init(
                    imageURL: URL(string: "https://picsum.photos/id/235/300/200"),
                    description: "Vivamus integer non suscipit taciti mus etiam at primis tempor sagittis sit, euismod libero facilisi aptent elementum felis blandit cursus gravida sociis erat ante, eleifend lectus nullam dapibus netus feugiat curae curabitur est ad."
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
}

extension SampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showTableView()

        case 1:
            showActionView()

        default:
            break
        }
    }
}
