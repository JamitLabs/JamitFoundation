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
        button.addTarget(self, action: #selector(didTriggerAction), for: .primaryActionTriggered)
        button.addTarget(self, action: #selector(didChangeButtonState), for: .allTouchEvents)
        button.addTarget(self, action: #selector(lateDidChangeButtonState), for: .allTouchEvents)

        isUserInteractionEnabled = true

        bringSubviewToFront(button)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        button.layer.cornerRadius = view.layer.cornerRadius

        if #available(iOS 11.0, tvOS 11.0, *) {
            button.layer.maskedCorners = view.layer.maskedCorners
        }
    }

    public override func didChangeModel() {
        super.didChangeModel()

        view.model = model.content
    }

    @objc
    private func didTriggerAction() {
        model.action()
    }

    @objc
    private func didChangeButtonState() {
        switch button.state {
        case .highlighted, .selected:
            willHighlight()

        default:
            willRemoveHighlighting()
        }
    }

    private func willHighlight() {
        switch model.highlightAnimation {
        case .normal:
            button.backgroundColor = UIColor.black.withAlphaComponent(0.15)

        case let .curveEaseInOut(duration):
            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                },
                completion: nil
            )

        case let .custom(animation):
            animation(view, button.state)
        }
    }

    private func willRemoveHighlighting() {
        switch model.highlightAnimation {
        case .normal:
            button.backgroundColor = UIColor.black.withAlphaComponent(0)

        case let .curveEaseInOut(duration):
            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.view.transform = .identity
                },
                completion: nil
            )

        case let .custom(animation):
            animation(view, button.state)
        }
    }

    @objc
    private func lateDidChangeButtonState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.didChangeButtonState()
        }
    }
}
