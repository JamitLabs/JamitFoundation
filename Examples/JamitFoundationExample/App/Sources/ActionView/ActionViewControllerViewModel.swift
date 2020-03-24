//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct ActionViewControllerViewModel: ViewModelProtocol {
    let imageURL: URL?

    init(imageURL: URL? = ActionViewControllerViewModel.default.imageURL) {
        self.imageURL = imageURL
    }
}

extension ActionViewControllerViewModel {
    static let `default`: ActionViewControllerViewModel = .init(
        imageURL: nil
    )
}
