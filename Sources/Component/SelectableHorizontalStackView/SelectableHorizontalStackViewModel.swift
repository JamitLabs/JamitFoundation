public struct SelectableHorizontalStackViewModel<ItemViewModel: ViewModelProtocol>: ViewModelProtocol {
    public typealias IndexChangeCallback = (Int) -> Void

    public var items: [ItemViewModel]
    public let onSelectedIndexChanged: IndexChangeCallback

    public init(
        items: [ItemViewModel] = Self.default.items,
        onSelectedIndexChanged: @escaping IndexChangeCallback = Self.default.onSelectedIndexChanged
    ) {
        self.items = items
        self.onSelectedIndexChanged = onSelectedIndexChanged
    }
}

extension SelectableHorizontalStackViewModel {
    public static var `default`: Self {
        .init(
            items: [],
            onSelectedIndexChanged: { _ in }
        )
    }
}
