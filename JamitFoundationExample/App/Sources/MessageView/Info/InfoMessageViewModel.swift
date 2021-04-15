// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct InfoMessageViewModel: ViewModelProtocol {
    let title: String?
    let message: String?

    init(
        title: String? = Self.default.title,
        message: String? = Self.default.message
    ) {
        self.title = title
        self.message = message
    }
}

extension InfoMessageViewModel {
    static let `default`: Self = .init(
        title: nil,
        message: nil
    )
}
