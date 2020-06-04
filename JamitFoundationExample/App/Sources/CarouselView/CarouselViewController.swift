//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import CarouselView
import JamitFoundation
import UIKit

final class CarouselViewController: StatefulViewController<CarouselViewControllerViewModel> {
    @IBOutlet private var contentView: UIView!

    private lazy var carouselView: CarouselView<CarouselItemView> = {
        let carouselView = CarouselView<CarouselItemView>()
        return carouselView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CarouselViewController"

        carouselView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(carouselView)
        carouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        carouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        carouselView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        carouselView.model = .init(pages: model.carouselItemViewModels)
    }
}
