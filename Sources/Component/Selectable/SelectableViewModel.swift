import UIKit

public struct SelectableViewModel<Content: ViewModelProtocol>: ViewModelProtocol {
    public typealias OnSelectionCallback = (Bool) -> Void

    public let content: Content
    public var isSelected: Bool
    public let onSelected: OnSelectionCallback

    public init(
        content: Content = Self.default.content,
        isSelected: Bool = Self.default.isSelected,
        onSelected: @escaping OnSelectionCallback = Self.default.onSelected
    ) {
        self.content = content
        self.isSelected = isSelected
        self.onSelected = onSelected
    }
}

extension SelectableViewModel {
    public static var `default`: SelectableViewModel<Content> {
        .init(content: .default, isSelected: false, onSelected: { _ in })
    }
}
