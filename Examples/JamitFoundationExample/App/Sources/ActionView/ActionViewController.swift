//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class ActionViewController: StatefulViewController<ActionViewControllerViewModel> {
    @IBOutlet weak var actionViewContainer: UIView!

    private lazy var actionView: ActionView<ImageView> = {
        let actionView = ActionView<ImageView>.instantiate()
        return actionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ActionViewController"

        actionView.translatesAutoresizingMaskIntoConstraints = false
        actionViewContainer.addSubview(actionView)
        actionView.leadingAnchor.constraint(equalTo: actionViewContainer.leadingAnchor).isActive = true
        actionView.trailingAnchor.constraint(equalTo: actionViewContainer.trailingAnchor).isActive = true
        actionView.topAnchor.constraint(equalTo: actionViewContainer.topAnchor).isActive = true
        actionView.bottomAnchor.constraint(equalTo: actionViewContainer.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        guard let imageURL = model.imageURL else { return }

        actionView.model = .init(content: .url(imageURL)) { [weak self] in
            self?.didTapActionView()
        }
    }

    private func didTapActionView() {
        let alert = UIAlertController(
            title: "You did tap the image",
            message: "This alert controller is being shown due to tapping on the image and the action view taking care of it.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

        present(alert, animated: true)
    }
}
