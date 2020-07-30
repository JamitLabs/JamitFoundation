//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

typealias SampleCollectionViewSupplymentaryModel = SampleCollectionViewViewModel.SupplementaryModel
typealias SampleCollectionViewItemModel = SampleCollectionViewViewModel.ItemModel

struct SampleCollectionViewViewModel: ViewModelProtocol {
    typealias ItemModel = FancyLabelViewModel
    typealias SupplementaryModel = FancyLabelViewModel

    var header: SupplementaryModel?
    var footer: SupplementaryModel?
    var items: [ItemModel]

    init(
        header: SupplementaryModel? = Self.default.header,
        footer: SupplementaryModel? = Self.default.footer,
        items: [ItemModel] = Self.default.items
    ) {
        self.header = header
        self.footer = footer
        self.items = items
    }
}

extension SampleCollectionViewViewModel {
    static let `default`: Self = .init(
        header: nil,
        footer: nil,
        items: []
    )
}
