// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit
import SwiftUI
import SwiftUISupport

protocol SwiftUIIntegrationViewControllerDelegate: AnyObject {
    // TODO: not yet implemented
}

final class SwiftUIIntegrationViewController: StatefulViewController<SwiftUIIntegrationViewModel> {
    weak var delegate: SwiftUIIntegrationViewControllerDelegate?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var candyButtonContainer: UIView!

    private lazy var candyButtonSwiftUIView: SwiftUIContainerView<AnyView> = .init(parentViewController: self, contentView: AnyView(CandyButton {
        [weak self] in
            self?.teleportToCandyland()
    }
    ))

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        candyButtonContainer.addSubview(candyButtonSwiftUIView)
        candyButtonSwiftUIView.translatesAutoresizingMaskIntoConstraints = false
        candyButtonSwiftUIView.isUserInteractionEnabled = false

        candyButtonSwiftUIView.topAnchor.constraint(equalTo: candyButtonContainer.topAnchor).isActive = true
        candyButtonSwiftUIView.leadingAnchor.constraint(equalTo: candyButtonContainer.leadingAnchor).isActive = true
        candyButtonSwiftUIView.trailingAnchor.constraint(equalTo: candyButtonContainer.trailingAnchor).isActive = true
        candyButtonSwiftUIView.bottomAnchor.constraint(equalTo: candyButtonContainer.bottomAnchor).isActive = true
//        candyButtonSwiftUIView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
//        candyButtonSwiftUIView.backgroundColor = .red
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
