//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

struct CollapsibleViewControllerViewModel: ViewModelProtocol {
    let headerTitles: [String]
    let headerTitleFont: UIFont
    let headerArrowImage: UIImage?

    init(
        headerTitles: [String] = Self.default.headerTitles,
        headerTitleFont: UIFont = Self.default.headerTitleFont,
        headerArrowImage: UIImage? = Self.default.headerArrowImage
    ) {
        self.headerTitles = headerTitles
        self.headerTitleFont = headerTitleFont
        self.headerArrowImage = headerArrowImage
    }
}

extension CollapsibleViewControllerViewModel {
    static var `default`: Self = .init(
        headerTitles: [],
        headerTitleFont: .systemFont(ofSize: 16.0),
        headerArrowImage: UIImage(named: "icArrowUp")
    )
}
