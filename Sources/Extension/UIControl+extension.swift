//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

@objc
private class CallbackWrapper: NSObject {
    private let callback: VoidCallback?

    init(_ callback: VoidCallback?) {
        self.callback = callback
    }

    @objc
    func invoke () {
        callback?()
    }
}

public extension UIControl {
    private struct AssociatedKey {
        static var callbackWrapper: UInt8 = 0
    }

    /// Add an action to a UIControl by simply passing the control event. The callback will then be notified when this event is being triggered.
    func addAction(for controlEvent: UIControl.Event = .primaryActionTriggered, _ callback: VoidCallback?) {
        let callbackWrapper = CallbackWrapper(callback)
        addTarget(callbackWrapper, action: #selector(callbackWrapper.invoke), for: controlEvent)

        objc_setAssociatedObject(self, &AssociatedKey.callbackWrapper, callbackWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
