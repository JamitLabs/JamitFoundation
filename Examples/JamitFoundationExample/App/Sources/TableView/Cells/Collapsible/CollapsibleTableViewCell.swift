//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class CollapsibleTableViewCell: ContainerTableViewCell<CollapsibleView<DefaultCollapsibleHeaderView>> {
    var didChangeState: Bool = false

    override class var isDynamicallyResizable: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        selectionStyle = .none
    }
}
