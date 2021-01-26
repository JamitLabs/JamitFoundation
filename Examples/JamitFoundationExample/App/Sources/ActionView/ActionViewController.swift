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
        firstActionView.view.layer.cornerRadius = 20.0
        if #available(iOS 11.0, *) {
            firstActionView.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        let secondLabel: UILabel = .init()
        secondLabel.text = "Highlighting curveEaseInOut"
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(secondActionView)
        secondActionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

        secondActionView.view.layer.cornerRadius = 20.0
        
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
            highlightAnimation: .normal
        ) {
            NSLog("Did tap firstActionView with highlight animation normal")
        }

        secondActionView.contentMode = .scaleAspectFit
        secondActionView.model = .init(
            content: .url(imageURL),
            highlightAnimation: .curveEaseInOut(duration: 0.3)
        ) {
            NSLog("Did tap secondActionView with highlight animation curveEaseInOut")
        }

        thirdActionView.contentMode = .scaleAspectFit
        thirdActionView.model = .init(
            content: .url(imageURL),
            highlightAnimation: .custom(customHighlightAnimation)
        ) {
            NSLog("Did tap thirdActionView with highlight animation custom")
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
}
