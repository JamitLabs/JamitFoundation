// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit
import SwiftUI
import SwiftUISupport

final class SwiftUIIntegrationViewController: StatefulViewController<SwiftUIIntegrationViewModel> {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var candyButtonContainer: UIView!

    private lazy var candyButtonSwiftUIView: SwiftUIContainerView<CandyButton> = .init(parentViewController: self, contentView: CandyButton {
        [weak self] in
            self?.teleportToCandyland()
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        candyButtonContainer.addSubview(candyButtonSwiftUIView)
        candyButtonSwiftUIView.translatesAutoresizingMaskIntoConstraints = false
        candyButtonSwiftUIView.isUserInteractionEnabled = false

        candyButtonSwiftUIView.topAnchor.constraint(equalTo: candyButtonContainer.topAnchor).isActive = true
        candyButtonSwiftUIView.leadingAnchor.constraint(equalTo: candyButtonContainer.leadingAnchor).isActive = true
        candyButtonSwiftUIView.trailingAnchor.constraint(equalTo: candyButtonContainer.trailingAnchor).isActive = true
        candyButtonSwiftUIView.bottomAnchor.constraint(equalTo: candyButtonContainer.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
    }

    private func teleportToCandyland() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .purple
        present(viewController, animated: true, completion: nil)
    }
}
