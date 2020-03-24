//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct TableViewViewModel: ViewModelProtocol {
    enum Item {
        case title(TableViewTitleViewModel)
        case item(TableViewItemViewModel)
    }

    let items: [Item]

    init(items: [Item] = TableViewViewModel.default.items) {
        self.items = items
    }
}

extension TableViewViewModel {
    static let `default`: TableViewViewModel = .init(
        items: []
    )
}
