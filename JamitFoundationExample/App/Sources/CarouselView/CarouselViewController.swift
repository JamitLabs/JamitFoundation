//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import CarouselView
import JamitFoundation
import UIKit

final class CarouselViewController: StatefulViewController<CarouselViewControllerViewModel> {
    @IBOutlet private var contentView: UIView!

    private lazy var carouselView: CarouselView<CarouselItemView> = .instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CarouselViewController"

        contentView.addSubview(carouselView)

        carouselView.constraintEdgesToParent()
    }

    override func didChangeModel() {
        super.didChangeModel()

        carouselView.model = .init(pages: model.carouselItemViewModels)
    }
}
