//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct TabBarItemViewModel: ViewModelProtocol {
    let text: String?
    let didSelectItem: VoidCallback?

    init(
        text: String? = Self.default.text,
        didSelectItem: VoidCallback? = Self.default.didSelectItem
    ) {
        self.text = text
        self.didSelectItem = didSelectItem
    }
}

extension TabBarItemViewModel {
    static let `default`: Self = .init(
        text: nil,
        didSelectItem: nil
    )
}
