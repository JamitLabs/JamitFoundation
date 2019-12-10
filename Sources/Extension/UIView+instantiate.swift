import Foundation
import UIKit

public extension UIView {
    /// Instantiates a new view based on the inferred result type.
    ///
    /// The view will be instantiated from a nib file when there
    /// is a nib file inside the given Bundle which has the same name
    /// as the inferred class name of the UIView.
    ///
    /// Example:
    ///
    /// ```swift
    /// // If a nib file with the name `MyView` exists then it will be instantiated,
    /// // else the default initializer of `UIView` will be used.
    ///
    /// // `-instantiate` returns an instance of type `MyView`.
    /// let myView: MyView = .instantiate()
    ///
    /// // `-instantiate` returns an instance of type `MyOtherView`.
    /// let mySecondView = MyOtherView.instantiate()
    /// ```
    ///
    /// The view will be instantiated using the default initializer
    /// `init(frame:)` when there is no nib file found.
    ///
    /// - Parameter bundle: The resource bundle used to lookup for the nib.
    /// - Parameter owner: The File's Owner used when instantiating from a nib.
    /// - Parameter options: The options used when instantiating from a nib.
    class func instantiate(
        bundle: Bundle? = nil,
        withOwner owner: Any? = nil,
        options: [UINib.OptionsKey: Any]? = nil
    ) -> Self {
        return _instantiate(bundle: bundle, withOwner: owner, options: options)
    }

    private class func _instantiate<View: UIView>(
        bundle: Bundle? = nil,
        withOwner owner: Any? = nil,
        options: [UINib.OptionsKey: Any]? = nil
    ) -> View {
        let identifier = String(describing: View.self)
        let bundle = bundle ?? .main
        if bundle.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: bundle)
            return nib.instantiate(withOwner: owner, options: options).first as! View
        }

        return View(frame: .zero)
    }
}
