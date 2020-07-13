//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class ActionViewController: StatefulViewController<ActionViewControllerViewModel> {
    @IBOutlet private var stackView: UIStackView!

    private lazy var firstActionView: ActionView<ImageView> = .instantiate()
    private lazy var secondActionView: ActionView<ImageView> = .instantiate()
    private lazy var thirdActionView: ActionView<ImageView> = .instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ActionViewController"

        let firstLabel: UILabel = .init()
        firstLabel.text = "Highlighting normal"
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(firstActionView)
        firstActionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        let secondLabel: UILabel = .init()
        secondLabel.text = "Highlighting curveEaseInOut"
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(secondActionView)
        secondActionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        let thirdLabel: UILabel = .init()
        thirdLabel.text = "Highlighting custom"
        stackView.addArrangedSubview(thirdLabel)
        stackView.addArrangedSubview(thirdActionView)
        thirdActionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        guard let imageURL = model.imageURL else { return }

        firstActionView.contentMode = .scaleAspectFit
        firstActionView.model = .init(
            content: .url(imageURL),
            highlightAnimation: .normal,
            cornerRadius: 20
        ) { [weak self] in
            self?.didTapActionView()
        }

        secondActionView.contentMode = .scaleAspectFit
        secondActionView.model = .init(
            content: .url(imageURL),
            highlightAnimation: .curveEaseInOut(duration: 0.3),
            cornerRadius: 20
        ) { [weak self] in
            self?.didTapActionView()
        }

        thirdActionView.contentMode = .scaleAspectFit
        thirdActionView.model = .init(
            content: .url(imageURL),
            highlightAnimation: .custom(customHighlightAnimation),
            cornerRadius: 20
        ) { [weak self] in
            self?.didTapActionView()
        }
    }
    
    private func customHighlightAnimation(view: UIView, state: UIControl.State) {
        switch state {
        case .highlighted, .selected:
            UIView.animate(withDuration: 1.0) {
                view.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 4.0), 1.0, 0.0, 0.0)
            }

        default:
            UIView.animate(withDuration: 1.0) {
                view.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 4.0), 0.0, 0.0, 0.0)
            }
        }
    }

    private func didTapActionView() {
        let alert = UIAlertController(
            title: NSLocalizedString("ACTION_VIEW.ALERT.TITLE", comment: ""),
            message: NSLocalizedString("ACTION_VIEW.ALERT.MESSAGE", comment: ""),
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: NSLocalizedString("ACTION_VIEW.ALERT.ACTION.TITLE", comment: ""), style: .default, handler: nil))

        present(alert, animated: true)
    }
}
