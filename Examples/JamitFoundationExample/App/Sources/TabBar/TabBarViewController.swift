//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class TabBarViewController: StatefulViewController<TabBarViewModel> {
    private lazy var contentView: UIView = .init()
    private lazy var tabBar: SelectableHorizontalStackView<TabBarItemView> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        // TODO: determine correct top anchor, check if navigation bar is present
        // and if so use that bottom anchor instead use the views top anchor
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)
        contentView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        // TODO: make adjustable through model
        tabBar.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func didChangeModel() {
        super.didChangeModel()

        tabBar.model = .init(
            items: model.items.map { return $0.tabBarItemView.model },
            selectedItemIndex: model.selectedTabItemIndex,
            onSelectedIndexChanged: { [weak self] index in
                self?.model.items[index].tabBarItemView.model.didSelectItem?()

                guard
                    let self = self,
                    !self.contentView.subviews.contains(self.model.items[index].view)
                else {
                    return
                }

                self.contentView.subviews.forEach { $0.removeFromSuperview() }

                let newContentViewController = self.model.items[index]
                guard let newContentView = newContentViewController.view else { return }

                self.addChild(newContentViewController)

                newContentView.translatesAutoresizingMaskIntoConstraints = false
                self.contentView.addSubview(newContentView)
                newContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
                newContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
                newContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
                newContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            }
        )
    }
}
