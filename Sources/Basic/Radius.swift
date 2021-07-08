import Foundation
import UIKit

/// An enumeration to describe differnt types of `Radius`.
public enum Radius {
    /// A circular radius depending on the frame size of its owner.
    case circular

    /// A constant value radius applied to all edges of its owner.
    case all(CGFloat)
}

extension Radius: ExpressibleByFloatLiteral {
    /// Creates an instance initialized to the specified floating-point value.
    ///
    /// Do not call this initializer directly. Instead, initialize a variable or
    /// constant using a floating-point literal. For example:
    ///
    ///     let x = 21.5
    ///
    /// In this example, the assignment to the `x` constant calls this
    /// floating-point literal initializer behind the scenes.
    ///
    /// - Parameter value: The value to create.
    public init(floatLiteral value: CGFloat.NativeType) {
        self = .all(CGFloat(floatLiteral: value))
    }
}

extension Radius: ExpressibleByIntegerLiteral {
    /// Creates an instance initialized to the specified integer value.
    ///
    /// Do not call this initializer directly. Instead, initialize a variable or
    /// constant using an integer literal. For example:
    ///
    ///     let x = 23
    ///
    /// In this example, the assignment to the `x` constant calls this integer
    /// literal initializer behind the scenes.
    ///
    /// - Parameter value: The value to create.
    public init(integerLiteral value: Int) {
        self = .all(CGFloat(integerLiteral: value))
    }
}
