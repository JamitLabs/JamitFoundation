import Foundation
import UIKit

/// A stateful view which adds tab action behaviour to an embedded `ContentView`.
///
/// Example:
/// ```swift
/// // Represents an image view with tab gesture behaviour.
/// let imageSourceURL: URL = <#image source#>
/// let contentView = ActionView<ImageView>.instantiate()
///
/// contentView.model = .init(content: .url(imageSourceURL)) {
///     print("Did tap contentView!")
/// )
/// ```
public final class ActionView<ContentView: StatefulViewProtocol>: StatefulView<ActionViewModel<ContentView.Model>> {
    /// The underlying view which is embedded into the `contentView`.
    public private(set) lazy var view: ContentView = .instantiate()
    private lazy var button: UIButton = .instantiate()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.addTarget(self, action: #selector(didTriggerAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(updateBackgroundColor), for: .allTouchEvents)
        button.addTarget(self, action: #selector(lateUpdateBackgroundColor), for: .allTouchEvents)

        isUserInteractionEnabled = true

        bringSubviewToFront(button)
    }

    public override func didChangeModel() {
        super.didChangeModel()

        view.model = model.content

        guard let cornerRadius = model.cornerRadius else { return }

        view.layer.cornerRadius = cornerRadius
        button.layer.cornerRadius = cornerRadius
    }

    @objc
    private func didTriggerAction() {
        model.action()
    }

    @objc
    private func updateBackgroundColor() {
        if [.highlighted, .selected].contains(button.state) {
            switch model.highlightAnimation {
            case .normal:
                button.backgroundColor = UIColor.black.withAlphaComponent(0.15)

            case .curveEaseInOut:
                UIView.animate(
                    withDuration: model.animationDuration,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: {
                        self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    },
                    completion: nil
                )
            }
        } else {
            switch model.highlightAnimation {
            case .normal:
                button.backgroundColor = UIColor.black.withAlphaComponent(0)

            case .curveEaseInOut:
                UIView.animate(
                    withDuration: model.animationDuration,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: {
                        self.view.transform = .identity
                    },
                    completion: nil
                )
            }
        }
    }

    @objc
    private func lateUpdateBackgroundColor() {
        DispatchQueue.main.asyncAfter(deadline: .now() + model.animationDuration) { [weak self] in
            self?.updateBackgroundColor()
        }
    }
}
