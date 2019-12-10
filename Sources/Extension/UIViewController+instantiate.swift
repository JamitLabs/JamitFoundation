import Foundation
import UIKit

public extension UIViewController {
    /// Instantiates a new view controller based on the inferred result type.
    ///
    /// The view controller will be instantiated from a nib file when
    /// there is a nib file inside the given Bundle which has the same name
    /// as the inferred class name of the UIViewController
    ///
    /// Example:
    /// 
    /// ```swift
    /// // If a nib file with the name `MyViewController` exists then it will be instantiated,
    /// // else the default initializer of `UIViewController` will be used.
    ///
    /// // `-instantiate` returns an instance of type `MyViewController`.
    /// let myViewController: MyViewController = .instantiate()
    ///
    /// // `-instantiate` returns an instance of type `MyOtherViewController`.
    /// let mySecondViewController = MyOtherViewController.instantiate()
    /// ```
    ///
    /// The view controller will be instantiated using the default initializer
    /// `init(nibName:, bundle:)` when there is no nib file found.
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

    private class func _instantiate<ViewController: UIViewController>(
        bundle: Bundle? = nil,
        withOwner owner: Any? = nil,
        options: [UINib.OptionsKey: Any]? = nil
    ) -> ViewController {
        let identifier = String(describing: ViewController.self)
        let bundle = bundle ?? .main
        if bundle.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: bundle)
            return nib.instantiate(withOwner: owner, options: options).first as! ViewController
        }

        return ViewController(nibName: nil, bundle: nil)
    }
}
