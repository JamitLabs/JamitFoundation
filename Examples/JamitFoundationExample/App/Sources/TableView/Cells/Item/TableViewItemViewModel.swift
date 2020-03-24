//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import Foundation

struct TableViewItemViewModel: ViewModelProtocol {
    let imageURL: URL?
    let description: String?

    init(
        imageURL: URL? = TableViewItemViewModel.default.imageURL,
        description: String? = TableViewItemViewModel.default.description
    ) {
        self.imageURL = imageURL
        self.description = description
    }
}

extension TableViewItemViewModel {
    static let `default`: TableViewItemViewModel = .init(
        imageURL: nil,
        description: nil
    )
}
