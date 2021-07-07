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

    /// The line break mode of the `Label`.
    public let lineBreakMode: NSLineBreakMode

    /// The text alignment of the `Label`.
    public let textAlignment: NSTextAlignment

    /// The designated initializer of `LabelStyle`.
    ///
    /// - Parameters:
    ///   - color: The color used to render the text of a `Label`.
    ///   - font: The font used to render the text of a `Label`.
    ///   - numberOfLines: The number of lines the `Label` is allowed to line break.
    ///   - lineBreakMode: The line break mode of the `Label`.
    ///   - textAlignment: The text alignment of the `Label`.
    public init(
        color: UIColor = Self.default.color,
        font: UIFont = Self.default.font,
        numberOfLines: Int = Self.default.numberOfLines,
        lineBreakMode: NSLineBreakMode = Self.default.lineBreakMode,
        textAlignment: NSTextAlignment = Self.default.textAlignment
    ) {
        self.color = color
        self.font = font
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.textAlignment = textAlignment
    }
}

extension LabelStyle {
    /// The default value of `LabelStyle`.
    public static let `default`: Self = .init(
        color: Self.defaultColor(),
        font: .systemFont(ofSize: 17),
        numberOfLines: 1,
        lineBreakMode: .byTruncatingTail,
        textAlignment: .natural
    )

    private static func defaultColor() -> UIColor {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
}
