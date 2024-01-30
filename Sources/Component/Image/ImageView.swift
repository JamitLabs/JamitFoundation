import Foundation
import UIKit

/// Error type to describe contextual error cases inside the `ImageView`.
public enum ImageViewError: Error {
    /// Describes an image decoding error.
    case imageDecodingError
    /// Describes an networking error with an underlying error as argument.
    case networkError(Error)
}

/// A stateful view which presents an image based on the current `Image` state.
public final class ImageView: StatefulView<Image> {
    private typealias ImageCallback = (UIImage) -> Void

    private lazy var imageView: UIImageView = .init(frame: .zero)
    private lazy var activityIndicator: UIActivityIndicatorView = .init(style: .gray)

    private var errorCallback: ErrorCallback?

    public override var contentMode: UIView.ContentMode {
        didSet { imageView.contentMode = contentMode }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        addSubview(imageView)

        imageView.constraintEdgesToParent()

        addSubview(activityIndicator)

        activityIndicator.hidesWhenStopped = true
        activityIndicator.centerInParent()
    }

    public override func didChangeModel() {
        super.didChangeModel()

        switch model {
        case let .url(url):
            imageView.image = nil
            loadImage(from: url) { [weak self] image in
                self?.imageView.image = image
            }

        case let .image(image):
            imageView.image = image

        case .none:
            imageView.image = nil
        }
    }

    /// Registers a callback closure which gets called whenever an error occurs.
    ///
    /// - Parameter callback: The callback to be called.
    public func onError(_ callback: @escaping ErrorCallback) {
        errorCallback = callback
    }

    private func loadImage(from url: URL, callback: @escaping ImageCallback) {
        activityIndicator.startAnimating()

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async { [weak self] in
                defer { self?.activityIndicator.stopAnimating() }

                guard let data = data, let image = UIImage(data: data) else {
                    if let error = error {
                        self?.errorCallback?(ImageViewError.networkError(error))
                    } else {
                        self?.errorCallback?(ImageViewError.imageDecodingError)
                    }

                    return
                }

                callback(image)
            }
        }.resume()
    }
}
