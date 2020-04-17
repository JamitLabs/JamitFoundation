//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import Foundation

struct TableViewItemViewModel: ViewModelProtocol {
    let imageURL: URL?
    let details: String?

    init(
        imageURL: URL? = Self.default.imageURL,
        details: String? = Self.default.details
    ) {
        self.imageURL = imageURL
        self.details = details
    }
}

extension TableViewItemViewModel {
    static let `default`: Self = .init(
        imageURL: nil,
        details: nil
    )
}
