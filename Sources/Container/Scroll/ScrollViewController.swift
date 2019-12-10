import Foundation
import UIKit

/// A container view controller that adds a scroll behaviour to its embedded content.
public final class ScrollViewController: ViewController {
    public override var childForStatusBarStyle: UIViewController? { return contentViewController }
    public override var childForStatusBarHidden: UIViewController? { return contentViewController }
    public override var navigationItem: UINavigationItem { return contentViewController.navigationItem }

    private var isContentViewBeingPresented: Bool = false
    private var observations: [NSKeyValueObservation] = []

    /// The content view controller to be embedded into the scroll view.
    public private(set) var contentViewController: UIViewController

    private lazy var containerView: UIView = .init(frame: .zero)
    private lazy var scrollView: UIScrollView = .init(frame: .zero)
    private lazy var contentView: UIView = .init(frame: .zero)
    private var contentViewHeightConstraint: NSLayoutConstraint!

    /// A flag controlling the stretching behaviour of the view controller.
    ///
    /// If `shouldFillScrollViewContentHeight` is set to true, then
    /// the `contentViewController` will be constrained to the height of this view controller.
    public var shouldFillScrollViewContentHeight: Bool = false {
        didSet {
            guard isContentViewBeingPresented else { return }

            contentViewHeightConstraint.isActive = shouldFillScrollViewContentHeight
        }
    }

    public required init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Unimplemented!")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Unimplemented!")
    }

    public override func loadView() {
        containerView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        self.view = containerView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        addChild(contentViewController)
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentViewController.view)
        contentViewController.view.frame = contentView.bounds
        contentViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contentViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        contentViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        if #available(iOS 11.0, *) {
            contentViewHeightConstraint = contentViewController.view.heightAnchor.constraint(
                greaterThanOrEqualTo: scrollView.safeAreaLayoutGuide.heightAnchor
            )
        } else {
            contentViewHeightConstraint = contentViewController.view.heightAnchor.constraint(
                greaterThanOrEqualTo: scrollView.layoutMarginsGuide.heightAnchor
            )
        }

        contentViewHeightConstraint.isActive = shouldFillScrollViewContentHeight
        contentViewController.didMove(toParent: self)
        isContentViewBeingPresented = true
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addObservers()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        isContentViewBeingPresented = false
        removeObservers()
    }

    private func addObservers() {
        observations.append(
            contentViewController.observe(\.title, options: [.initial, .new]) { [unowned self] viewController, _ in
                self.title = viewController.title
            }
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateContentInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateContentInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    private func removeObservers() {
        observations.forEach { $0.invalidate() }
        observations.removeAll(keepingCapacity: true)
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func updateContentInsetForKeyboard(_ notification: Notification) {
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: view.window)
            if #available(iOS 11.0, *) {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - view.safeAreaInsets.bottom, right: 0)
            } else {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - view.layoutMargins.bottom, right: 0)
            }
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension UIViewController {
    /// Returns an instance of a `ScrollViewController` in the parent hierarchy of the view controller.
    var scrollViewController: ScrollViewController? {
        return (parent as? ScrollViewController) ?? parent?.scrollViewController
    }
}
