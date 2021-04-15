//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation

struct MyScrollViewControllerViewModel: ViewModelProtocol {
    let text: String?

    init(text: String? = Self.default.text) {
        self.text = text
    }
}

extension MyScrollViewControllerViewModel {
    static let `default`: Self = .init(
        text: nil
    )
}
