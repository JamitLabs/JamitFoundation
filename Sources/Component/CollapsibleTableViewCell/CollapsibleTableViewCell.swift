//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

public final class CollapsibleTableViewCell<HeaderView: StatefulViewProtocol>: ContainerTableViewCell<CollapsibleView<HeaderView>> {
    public override class var isDynamicallyResizable: Bool {
        return true
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        selectionStyle = .none
    }
}
