import Foundation
import UIKit

/// The base view which has a mutable state of type `Model`.
/// `Model` contains data required to setup the view correctly.
///
/// Every subclass of the `StatefulView` is intended to have a mutable state
/// and should only be configured by assigning it's `Model`.
///
/// Subviews inside a `StatefulView` should always be private and not accessible from outside.
/// Callbacks should also be passed as closures inside the `Model` so that no methods of the
/// view are called from outside.
open class StatefulView<Model: ViewModelProtocol>: UIView, StatefulViewProtocol {
    /// The current state of the view.
    public var model: Model = .default {
        didSet { didChangeModel() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        viewDidLoad()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        viewDidLoad()
    }

    /// This method is intended to be overridden by a subclass to perform setup after the initialization of the view.
    ///
    /// - Attention: Always ensure calling `super.viewDidLoad()` to avoid unexpected behaviour.
    open func viewDidLoad() {}

    /// This method is intended to be overridden by a subclass to listen for state changes.
    ///
    /// - Attention: Always ensure calling `super.didChangeModel()` to avoid unexpected behaviour.
    open func didChangeModel() {
        backgroundColor = model.backgroundColor
    }
}
