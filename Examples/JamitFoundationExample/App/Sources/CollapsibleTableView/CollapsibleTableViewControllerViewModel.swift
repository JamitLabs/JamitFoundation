//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct CollapsibleTableViewControllerViewModel: ViewModelProtocol {
    enum Item {
        case collapsible(CollapsibleViewModel<DefaultCollapsibleHeaderViewModel>)
    }

    var items: [Item]

    init(items: [Item] = Self.default.items) {
        self.items = items
    }
}

extension CollapsibleTableViewControllerViewModel {
    static var `default`: Self = .init(
        items: []
    )
}
