import Foundation
import UIKit

/// The state view model for `ActionView`.
public struct ActionViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    /// The different highlight animations for the action view
    public enum HighlightAnimation {
        /// Adjusts the background color
        case normal
        /// Transforms the content view
        case curveEaseInOut(duration: Double)
        
        case custom(((UIView, UIControl.State) -> Void))
    }

    /// A generic state view model for the embedded `Content` view.
    public let content: Content

    /// The highlight animation to perform.
    public let highlightAnimation: HighlightAnimation

    /// The action closure to be called when a tab gesture is recognized
    public let action: VoidCallback

    /// The default initializer of `ActionViewModel`.
    ///
    /// - Parameter content: A generic state view model for the embedded `Content` view.
    /// - Parameter highlightAnimation: The highlight animation to perform.
    /// - Parameter action: The action closure to be called when a tab gesture is recognized
    public init(
        content: Content = ActionViewModel.default.content,
        highlightAnimation: HighlightAnimation = ActionViewModel.default.highlightAnimation,
        action: @escaping VoidCallback = ActionViewModel.default.action
    ) {
        self.content = content
        self.highlightAnimation = highlightAnimation
        self.action = action
    }
}

extension ActionViewModel {
    /// The default state of `ActionViewModel`.
    public static var `default`: ActionViewModel<Content> {
        return .init(
            content: .default,
            highlightAnimation: .normal,
            action: {}
        )
    }
}
