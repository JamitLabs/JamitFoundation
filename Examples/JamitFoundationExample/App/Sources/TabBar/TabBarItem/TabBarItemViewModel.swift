//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct TabBarItemViewModel: ViewModelProtocol {
    let text: String?

    init(text: String? = Self.default.text) {
        self.text = text
    }
}

extension TabBarItemViewModel {
    static let `default`: Self = .init(text: nil)
}
