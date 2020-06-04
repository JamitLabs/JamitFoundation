//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct CarouselViewControllerViewModel: ViewModelProtocol {
    let carouselItemViewModels: [CarouselItemViewModel]

    init(carouselItemViewModels: [CarouselItemViewModel] = Self.default.carouselItemViewModels) {
        self.carouselItemViewModels = carouselItemViewModels
    }
}

extension CarouselViewControllerViewModel {
    static var `default`: Self = .init(
        carouselItemViewModels: [.default]
    )
}
