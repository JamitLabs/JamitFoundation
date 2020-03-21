import JamitFoundation

public struct TabBarViewModel<ItemViewModel: ViewModelProtocol>: ViewModelProtocol {
    public typealias IndexChangeCallback = (Int) -> Void

    public let items: [ItemViewModel]
    public let onSelectedIndexChanged: IndexChangeCallback

    public init(
        items: [ItemViewModel] = Self.default.items,
        onSelectedIndexChanged: @escaping IndexChangeCallback = Self.default.onSelectedIndexChanged
    ) {
        self.items = items
        self.onSelectedIndexChanged = onSelectedIndexChanged
    }
}

extension TabBarViewModel {
    public static var `default`: TabBarViewModel {
        .init(
            items: [],
            onSelectedIndexChanged: { _ in }
        )
    }
}
