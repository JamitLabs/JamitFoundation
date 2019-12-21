import Foundation
import UIKit

/// The base class to be used for custom table view cells.
@objc
open class TableViewCell: UITableViewCell {
    /// This method is intended to be overridden by a subclass to perform setup after the initialization of the cell.
    ///
    /// - Attention: Always ensure calling `super.viewDidLoad()` to avoid unexpected behaviour.
    @objc open func viewDidLoad() {}

    /// This method is intended to be overridden by a subclass to listen for state changes.
    ///
    /// - Attention: Always ensure calling `super.didChangeModel()` to avoid unexpected behaviour.
    @objc open func didChangeModel() {}
}
