//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct TabBarItemViewModel: ViewModelProtocol {
    let text: String?
    let contentView: UIView
    let didSelectItem: VoidCallback?

    init(
        text: String? = Self.default.text,
        contentView: UIView = Self.default.contentView,
        didSelectItem: VoidCallback? = Self.default.didSelectItem
    ) {
        self.text = text
        self.contentView = contentView
        self.didSelectItem = didSelectItem
    }
}

extension TabBarItemViewModel {
    static let `default`: Self = .init(
        text: nil,
        contentView: UIView(),
        didSelectItem: nil
    )
}
