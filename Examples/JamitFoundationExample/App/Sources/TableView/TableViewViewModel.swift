//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct TableViewViewModel: ViewModelProtocol {
    enum Item {
        case title(TableViewTitleViewModel)
        case item(TableViewItemViewModel)
        case collapsible(CollapsibleViewModel<DefaultCollapsibleHeaderViewModel>)
    }

    var items: [Item]

    init(items: [Item] = Self.default.items) {
        self.items = items
    }
}

extension TableViewViewModel {
    static let `default`: Self = .init(
        items: []
    )
}
