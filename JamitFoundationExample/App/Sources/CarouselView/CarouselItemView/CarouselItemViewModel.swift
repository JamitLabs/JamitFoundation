//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct CarouselItemViewModel: ViewModelProtocol {
    let backgroundColor: UIColor

    init(backgroundColor: UIColor = Self.default.backgroundColor) {
        self.backgroundColor = backgroundColor
    }
}

extension CarouselItemViewModel {
    static let `default`: Self = .init(
        backgroundColor: .white
    )
}
