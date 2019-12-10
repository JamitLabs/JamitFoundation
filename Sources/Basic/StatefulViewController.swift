import UIKit

/// The base view controller which has a mutable state of type `Model`.
/// `Model` contains data required to setup the view controller correctly.
///
/// Every subclass of the `StatefulViewController` is intended to have a
/// mutable state and should only be configured by assigning it's `Model`.
///
/// Subviews inside a `StatefulViewController` should always be private
/// and not accessible from outside.
/// Callbacks should be passed as closures inside the `Model` or by implementing
/// the delegate pattern so that no methods of the view controller are called from outside.
open class StatefulViewController<Model: ViewModelProtocol>: ViewController {
    /// The current state of the view controller.
    public var model: Model = .default {
        didSet { didChangeModel() }
    }

    /// This method is intended to be overridden by a subclass to listen for state changes.
    ///
    /// - Attention: Always ensure calling `super.didChangeModel()` to avoid unexpected behaviour.
    open func didChangeModel() {}
}
