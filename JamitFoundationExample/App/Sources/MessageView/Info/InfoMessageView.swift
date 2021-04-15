// Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class InfoMessageView: StatefulView<InfoMessageViewModel> {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
        messageLabel.text = model.message
    }
}
