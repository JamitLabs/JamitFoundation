public struct SelectableHorizontalStackViewModel<ItemViewModel: ViewModelProtocol>: ViewModelProtocol {
    public typealias IndexChangeCallback = (Int) -> Void

    public var items: [ItemViewModel]
    public var selectedItemIndex: Int
    public let onSelectedIndexChanged: IndexChangeCallback

    public init(
        items: [ItemViewModel] = Self.default.items,
        selectedItemIndex: Int = Self.default.selectedItemIndex,
        onSelectedIndexChanged: @escaping IndexChangeCallback = Self.default.onSelectedIndexChanged
    ) {
        self.items = items
        self.selectedItemIndex = selectedItemIndex
        self.onSelectedIndexChanged = onSelectedIndexChanged
    }
}

extension SelectableHorizontalStackViewModel {
    public static var `default`: Self {
        .init(
            items: [],
            selectedItemIndex: 0,
            onSelectedIndexChanged: { _ in }
        )
    }
}
