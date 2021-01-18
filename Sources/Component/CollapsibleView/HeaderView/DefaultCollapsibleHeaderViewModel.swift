//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

/// The state view model for `DefaultCollapsibleHeaderViewModel`.
public struct DefaultCollapsibleHeaderViewModel: ViewModelProtocol {
    /// The title of the header view.
    public let title: String?
    /// The font to use for the title of the header view.
    public let titleFont: UIFont
    /// The image used for the arrow.
    public let arrowImageUp: UIImage?
    /// The animation duration for the change of the arrow direction.
    public let arrowAnimationDuration: TimeInterval
    /// The size of the arrow image view.
    public let arrowImageViewSizeConstant: CGFloat
    /// The background color should be whit instead of clear
    public var backgroundColor: UIColor = .white

    public var headerViewHeightConstant: CGFloat

    /// The default initializer of `CollapsibleViewModel`.
    ///
    /// - Parameter title: The title of the header view.
    /// - Parameter titleFont: The font to use for the title of the header view.
    /// - Parameter arrowImageUp: The image used for the arrow.
    /// - Parameter arrowAnimationDuration: The animation duration for the change of the arrow direction.
    /// - Parameter arrowImageViewSizeConstant: The size of the arrow image view.
    public init(
        title: String? = Self.default.title,
        titleFont: UIFont = Self.default.titleFont,
        arrowImageUp: UIImage? = Self.default.arrowImageUp,
        headerViewHeightConstant: CGFloat = Self.default.headerViewHeightConstant,
        arrowAnimationDuration: TimeInterval = Self.default.arrowAnimationDuration,
        arrowImageViewSizeConstant: CGFloat = Self.default.arrowImageViewSizeConstant
    ) {
        self.title = title
        self.titleFont = titleFont
        self.arrowImageUp = arrowImageUp
        self.headerViewHeightConstant = headerViewHeightConstant
        self.arrowAnimationDuration = arrowAnimationDuration
        self.arrowImageViewSizeConstant = arrowImageViewSizeConstant
    }
}

extension DefaultCollapsibleHeaderViewModel {
    /// The default state of `DefaultCollapsibleHeaderViewModel`.
    public static let `default`: Self = .init(
        title: nil,
        titleFont: .systemFont(ofSize: 16),
        arrowImageUp: nil,
        headerViewHeightConstant: 44,
        arrowAnimationDuration: 0.3,
        arrowImageViewSizeConstant: 24.0
    )
}
