import UIKit

public struct SelectableViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    public typealias OnSelectionCallback = (Bool) -> Void

    public let content: Content
    public let onSelected: OnSelectionCallback

    public init(
        content: Content = Self.default.content,
        onSelected: @escaping OnSelectionCallback = Self.default.onSelected
    ) {
        self.content = content
        self.onSelected = onSelected
    }
}

extension SelectableViewModel {
    public static var `default`: SelectableViewModel<Content> {
        .init(content: .default, onSelected: { _ in })
    }
}
