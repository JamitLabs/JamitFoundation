import JamitFoundation
import UIKit

public struct LoadingButtonViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    public let content: Content
    public let indicatorStyle: UIActivityIndicatorView.Style

    public init(
        content: Content = Self.default.content,
        indicatorStyle: UIActivityIndicatorView.Style = Self.default.indicatorStyle
    ) {
        self.content = content
        self.indicatorStyle = indicatorStyle
    }
}

extension LoadingButtonViewModel {
    public static var `default`: LoadingButtonViewModel<Content> {
        .init(
            content: .default,
            indicatorStyle: .white
        )
    }
}
