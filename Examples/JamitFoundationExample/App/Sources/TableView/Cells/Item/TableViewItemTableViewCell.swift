//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation

final class TableViewItemTableViewCell: ContainerTableViewCell<TableViewItemView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        selectionStyle = .none
    }
}
