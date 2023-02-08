//  Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import UIKit

extension NSLayoutConstraint {
    /// Change the priority of a NSLayoutConstraint and returns it.
    /// 
    /// - Parameter priority: The priority to be set.
    /// - Returns: The constraint to which is applied.
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
