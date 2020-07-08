//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class TabBarItemView: StatefulView<TabBarItemViewModel> {
    private lazy var label: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        label.text = model.text
    }
}
