//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct FancyLabelViewModel: ViewModelProtocol {
    let title: String?
    let backgroundColor: UIColor

    init(
        title: String? = Self.default.title,
        backgroundColor: UIColor = Self.default.backgroundColor
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
    }
}

extension FancyLabelViewModel {
    static let `default`: Self = .init(
        title: nil,
        backgroundColor: .clear
    )
}
