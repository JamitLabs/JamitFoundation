//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct ListItemViewModel: ViewModelProtocol {
    let title: String?

    init(title: String? = Self.default.title) {
        self.title = title
    }
}

extension ListItemViewModel {
    static let `default`: Self = .init(
        title: nil
    )
}
