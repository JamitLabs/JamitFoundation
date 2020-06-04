//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

@objc
class ClosureWrapper: NSObject {
    private let closure: VoidCallback?

    init(_ closure: VoidCallback?) {
        self.closure = closure
    }

    @objc
    func invoke () {
        closure?()
    }
}

public extension UIControl {
    struct AssociatedKey {
        static var actionWrapper: UInt8 = 0
    }

    /// Add an action to a UIControl by simply passing the control event. The closure will then be notified when this event is being triggered.
    func addAction(for controlEvent: UIControl.Event = .primaryActionTriggered, _ closure: VoidCallback?) {
        let actionWrapper = ClosureWrapper(closure)
        addTarget(actionWrapper, action: #selector(actionWrapper.invoke), for: controlEvent)

        objc_setAssociatedObject(self, &AssociatedKey.actionWrapper, actionWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
