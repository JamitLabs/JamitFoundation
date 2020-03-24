//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation

struct MyScrollViewControllerViewModel: ViewModelProtocol {
    let text: String?

    init(text: String? = MyScrollViewControllerViewModel.default.text) {
        self.text = text
    }
}

extension MyScrollViewControllerViewModel {
    static let `default`: MyScrollViewControllerViewModel = .init(
        text: nil
    )
}
