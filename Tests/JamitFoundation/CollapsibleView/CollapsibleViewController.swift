//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class CollapsibleViewController: StatefulViewController<CollapsibleViewControllerViewModel> {
    private var contentView: UIView!
    private lazy var collapsibleView: CollapsibleView<DefaultCollapsibleHeaderView> = .instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CollapsibleViewController"
        contentView = .init()
        contentView.frame = view.frame

        collapsibleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collapsibleView)
        collapsibleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collapsibleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collapsibleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: model.headerTitles.first ?? "",
                titleFont: model.headerTitleFont,
                arrowImageUp: model.headerArrowImage,
                arrowAnimationDuration: 0.5
            ),
            items: [
                CollapsibleElementView(backgroundColor: .red, height: 100, text: "Item 1"),
                CollapsibleElementView(backgroundColor: .blue, height: 100, text: "Item 2")
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )
    }
}
