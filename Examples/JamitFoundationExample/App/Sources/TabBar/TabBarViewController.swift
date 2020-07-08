//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import TabBarView
import UIKit

final class TabBarViewController: StatefulViewController<TabBarViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar: TabBarView<TabBarItemView> = .instantiate()
        tabBar.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tabBar)
        tabBar.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tabBar.model = .init(
            items: [.init(text: "Hallo"), .init(text: "Hallo2"), .init(text: "Hallo3")],
            onSelectedIndexChanged: { index in
                tabBar.model.items[index] = .init(text: "Selected")
            }
        )
    }
}
