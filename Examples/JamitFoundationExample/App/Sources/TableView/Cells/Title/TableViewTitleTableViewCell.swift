//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation
import UIKit

final class TableViewTitleTableViewCell: ContainerTableViewCell<TableViewTitleView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectionStyle = .none
    }
}
