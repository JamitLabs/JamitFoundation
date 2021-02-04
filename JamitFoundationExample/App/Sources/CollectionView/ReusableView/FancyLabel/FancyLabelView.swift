//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class FancyLabelView: StatefulView<FancyLabelViewModel> {
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var titleLabel: Label!

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 6.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layer.masksToBounds = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
        backgroundView.backgroundColor = model.backgroundColor
    }
}
