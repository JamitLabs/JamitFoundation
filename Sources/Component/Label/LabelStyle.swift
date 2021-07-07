import Foundation
import UIKit

/// A data structure describing the styles of a `Label`.
public struct LabelStyle {
    /// The color used to render the text of a `Label`.
    public let color: UIColor

    /// The font used to render the text of a `Label`.
    public let font: UIFont

    /// The number of lines the `Label` is allowed to line break.
    public let numberOfLines: Int

    /// The designated initializer of `LabelStyle`.
    ///
    /// - Parameters:
    ///   - color: The color used to render the text of a `Label`.
    ///   - font: The font used to render the text of a `Label`.
    ///   - numberOfLines: The number of lines the `Label` is allowed to line break.
    public init(
        color: UIColor,
        font: UIFont,
        numberOfLines: Int
    ) {
        self.color = color
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension LabelStyle {
    /// The default value of `LabelStyle`.
    public static let `default`: Self = .init(
        color: Self.defaultColor(),
        font: .systemFont(ofSize: 17),
        numberOfLines: 1
    )

    private static func defaultColor() -> UIColor {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
}
