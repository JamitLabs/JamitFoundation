import UIKit

public final class LoadingButtonView<ContentView: StatefulViewProtocol>: StatefulView<LoadingButtonViewModel<ContentView.Model>> where ContentView: UIButton {
    private(set) var isLoading: Bool = false {
        didSet {
            guard oldValue != isLoading else { return }

            didChangeIsLoading()
        }
    }

    private(set) lazy var view: ContentView = .instantiate()
    private lazy var loadingIndicator: UIActivityIndicatorView = .init(style: .whiteLarge)

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        loadingIndicator.isHidden = true
        isUserInteractionEnabled = true
    }

    public override func didChangeModel() {
        super.didChangeModel()

        view.model = model.content
        loadingIndicator.style = model.indicatorStyle
    }

    public func startAnimating() {
        isLoading = true
    }

    public func stopAnimation() {
        isLoading = false
    }

    private func didChangeIsLoading() {
        view.titleLabel?.alpha = isLoading ? 0.0 : 1.0
        view.imageView?.alpha = isLoading ? 0.0 : 1.0
        view.isEnabled = !isLoading
        loadingIndicator.isHidden = !isLoading

        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}
