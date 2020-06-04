//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class CarouselItemView: StatefulView<CarouselItemViewModel> {
    @IBOutlet private var contentView: UIView!

    override func didChangeModel() {
        super.didChangeModel()

        contentView.backgroundColor = model.backgroundColor
    }
}
