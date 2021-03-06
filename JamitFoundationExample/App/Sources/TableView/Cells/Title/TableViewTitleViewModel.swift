//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct TableViewTitleViewModel: ViewModelProtocol {
    let title: String?

    init(title: String? = Self.default.title) {
        self.title = title
    }
}

extension TableViewTitleViewModel {
    static var `default`: Self = .init(
        title: nil
    )
}
