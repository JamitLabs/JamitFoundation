import Foundation
import UIKit

/// The base label that includes useful functionalities which occur commonly for a `UILabel`.
///
/// To apply automatic styling using the interface builder you can create many subclasses of
/// `Label` and apply custom stylings and inherit the labels inside of the interface builder
/// from your styles label classes.
///
/// Example:
///
/// ```swift
/// final class HeadlineLabel: Label {
///     // ... applies headline semantics related styling to itself ...
/// }
/// ```
@IBDesignable
open class Label: UILabel {
    /// The localization key to be used to localize the content text of the label.
    @IBInspectable
    private(set) var localizationKey: String?

    /// The style descriptor of the `Label`.
    public var style: LabelStyle = .default {
        didSet { didChangeStyle() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        defaultInit()
        viewDidLoad()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        defaultInit()
        viewDidLoad()
    }

    private func defaultInit() {
        backgroundColor = .clear

        if let localizationKey = localizationKey {
            text = NSLocalizedString(localizationKey, bundle: Bundle(for: type(of: self)), comment: "")
        }
    }

    /// This method is intended to be overridden by a subclass to perform setup after the initialization of the label.
    ///
    /// - Attention: Always ensure calling `super.viewDidLoad()` to avoid unexpected behaviour.
    open func viewDidLoad() {}


    /// This method is intended to be overridden by a subclass to listen for state changes.
    ///
    /// - Attention: Always ensure calling `super.didChangeModel()` to avoid unexpected behaviour.
    open func didChangeModel() {}

    /// This method is intended to be overriden by a subclass to listen for style changes.
    ///
    /// - Attention: Always ensure calling `super.didChangeStyle()` to avoid unexpected behaviour.
    open func didChangeStyle() {
        textColor = style.color
        font = style.font
        numberOfLines = style.numberOfLines
        lineBreakMode = style.lineBreakMode
        textAlignment = style.textAlignment
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        defaultInit()
    }
}
