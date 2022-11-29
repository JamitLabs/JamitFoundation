//  Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import UIKit

extension NSLayoutConstraint {
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
