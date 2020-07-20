//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class CollapsibleViewController: StatefulViewController<CollapsibleViewControllerViewModel> {
    @IBOutlet private var contentView: UIView!

    private lazy var firstCollapsibleView: CollapsibleView<DefaultCollapsibleHeaderView> = .instantiate()
    private lazy var secondCollapsibleView: CollapsibleView<DefaultCollapsibleHeaderView> = .instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CollapsibleViewController"

        firstCollapsibleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(firstCollapsibleView)
        firstCollapsibleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        firstCollapsibleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        firstCollapsibleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        secondCollapsibleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondCollapsibleView)
        secondCollapsibleView.topAnchor.constraint(equalTo: firstCollapsibleView.bottomAnchor).isActive = true
        secondCollapsibleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        secondCollapsibleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    override func didChangeModel() {
        super.didChangeModel()

        firstCollapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: model.headerTitles.first ?? "",
                titleFont: model.headerTitleFont,
                arrowImageUp: model.headerArrowImage,
                arrowAnimationDuration: 0.5
            ),
            items: [
                CollapsibleItemView(backgroundColor: .red, height: 44.0),
                CollapsibleItemView(backgroundColor: .blue, height: 44.0)
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )

        secondCollapsibleView.model = .init(
            headerViewModel: .init(
                title: model.headerTitles.last ?? "",
                titleFont: model.headerTitleFont,
                arrowImageUp: model.headerArrowImage
            ),
            items: [
                CollapsibleItemView(backgroundColor: .orange, height: 44.0),
                CollapsibleItemView(backgroundColor: .green, height: 64.0)
            ],
            isCollapsed: false,
            animationDuration: 0.2
        )
    }
}
