import Foundation
import UIKit

/// The base view controller type that includes useful functionalities which occur commonly.
open class ViewController: UIViewController {
    private var onDismissCallback: VoidCallback?

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParent || isBeingDismissed {
            onDismissCallback?()
        }
    }

    /// Registers a callback closure which is called when the view controller is being dismissed.
    ///
    /// - Parameter callback: The closure to be called.
    public func onDismiss(_ callback: @escaping VoidCallback) {
        onDismissCallback = callback
    }
}
