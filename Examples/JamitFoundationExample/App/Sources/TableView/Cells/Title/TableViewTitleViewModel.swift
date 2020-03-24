//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct TableViewTitleViewModel: ViewModelProtocol {
    let title: String?

    init(title: String? = TableViewTitleViewModel.default.title) {
        self.title = title
    }
}

extension TableViewTitleViewModel {
    static var `default`: TableViewTitleViewModel = .init(
        title: nil
    )
}
