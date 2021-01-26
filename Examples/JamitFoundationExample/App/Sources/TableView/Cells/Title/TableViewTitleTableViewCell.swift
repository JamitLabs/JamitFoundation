//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class TableViewTitleTableViewCell: ContainerTableViewCell<TableViewTitleView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        selectionStyle = .none
    }
}
