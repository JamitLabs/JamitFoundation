//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

class ListItemView: StatefulView<ListItemViewModel> {

    @IBOutlet weak var titleLabel: UILabel!

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
    }
}
