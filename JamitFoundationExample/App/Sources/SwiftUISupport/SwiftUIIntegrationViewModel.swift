// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct SwiftUIIntegrationViewModel: ViewModelProtocol {
    let title: String?

    init(title: String? = SwiftUIIntegrationViewModel.default.title) {
        self.title = title
    }
}

extension SwiftUIIntegrationViewModel {
    static var `default`: SwiftUIIntegrationViewModel = .init(title: "This is a UILabel")
}
