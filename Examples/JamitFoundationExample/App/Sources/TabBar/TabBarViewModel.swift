//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct TabBarViewModel: ViewModelProtocol {
    let items: [TabBarItemViewModel]
    var selectedTabItemIndex: Int

    init(
        items: [TabBarItemViewModel] = Self.default.items,
        selectedTabItemIndex: Int = Self.default.selectedTabItemIndex
    ) {
        self.items = items
        self.selectedTabItemIndex = selectedTabItemIndex
    }
}

extension TabBarViewModel {
    static let `default`: Self = .init(
        items: [],
        selectedTabItemIndex: 0
    )
}
