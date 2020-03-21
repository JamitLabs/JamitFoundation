import UIKit

public struct SelectableViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    public typealias OnSelectionCallback = (Bool) -> Void

    public let content: Content
    public let action: VoidCallback
    public let onSelected: OnSelectionCallback

    public init(
        content: Content = Self.default.content,
        action: @escaping VoidCallback = Self.default.action,
        onSelected: @escaping OnSelectionCallback = Self.default.onSelected
    ) {
        self.content = content
        self.action = action
        self.onSelected = onSelected
    }
}

extension SelectableViewModel {
    public static var `default`: SelectableViewModel<Content> {
        .init()
    }
}
