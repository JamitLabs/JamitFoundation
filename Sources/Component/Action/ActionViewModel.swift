import Foundation
import UIKit

/// The state view model for `ActionView`.
public struct ActionViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    /// A generic state view model for the embedded `Content` view.
    public let content: Content
    
    /// Set this to be able to have a rounded action view
    public let cornerRadius: CGFloat?

    /// The duration of the tab gesture highlighting animation.
    public let animationDuration: TimeInterval

    /// The action closure to be called when a tab gesture is recognized
    public let action: VoidCallback

    /// The default initializer of `ActionViewModel`.
    ///
    /// - Parameter content: A generic state view model for the embedded `Content` view.
    /// - Parameter cornerRadius: Set this to be able to have a rounded action view
    /// - Parameter animationDuration: The duration of the tab gesture highlighting animation.
    /// - Parameter action: The action closure to be called when a tab gesture is recognized
    public init(
        content: Content = ActionViewModel.default.content,
        cornerRadius: CGFloat? = ActionViewModel.default.cornerRadius,
        animationDuration: TimeInterval = ActionViewModel.default.animationDuration,
        action: @escaping VoidCallback = ActionViewModel.default.action
    ) {
        self.content = content
        self.cornerRadius = cornerRadius
        self.animationDuration = animationDuration
        self.action = action
    }
}

extension ActionViewModel {
    /// The default state of `ActionViewModel`.
    public static var `default`: ActionViewModel<Content> {
        return .init(
            content: .default,
            cornerRadius: nil,
            animationDuration: 0.2,
            action: {}
        )
    }
}
