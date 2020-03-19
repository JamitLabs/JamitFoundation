import JamitFoundation

struct TabBarViewModel<ItemViewModel: ViewModelProtocol>: ViewModelProtocol {
    typealias IndexChangeCallback = (Int) -> Void

    let items: [ItemViewModel]
    let onSelectedIndexChanged: IndexChangeCallback

    init(
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
