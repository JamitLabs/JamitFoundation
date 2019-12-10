import Foundation
import UIKit

/// A base protocol meeting all requirements of a stateful view.
public protocol StatefulViewProtocol: UIView {
    associatedtype Model: ViewModelProtocol

    /// The current state of the view.
    var model: Model { get set }
}
