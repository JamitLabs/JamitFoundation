import JamitFoundation
import SwiftUI
import UIKit

@available(iOS 13.0, *)
/// Takes a swiftui view as a generic type and wraps it into a `StatefulView`.
public class SwiftUIContainerView<ContentView: View>: StatefulView<EmptyViewModel> {
    /// The UIViewController that holds the view hierarchy in which the `SwiftUIContainerView` is added as a subview
    public weak var parentViewController: UIViewController?
    private let contentView: ContentView

    private lazy var hostingController: UIHostingController<AnyView> = {
        .init(
            rootView:  AnyView(
                contentView.environmentObject(
                    NavigationCoordinator(
                        navigationControllerProvider: self
                    )
                )
            )
        )
    }()

    /// Initializes a `StatefulViewRepresentable`
    ///
    /// - Parameters:
    ///    - parentViewController: The UIViewController that manages the view hierarchy to which then `SwiftUIContainerView` is added.
    ///    - contentView: The SwiftUI view to be wrapped
    public init(parentViewController: UIViewController, contentView: ContentView) {
        self.parentViewController = parentViewController
        self.contentView = contentView

        super.init(frame: .zero)
        isUserInteractionEnabled = false
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        guard let newSuperview = newSuperview else {
            setUpConstraints(to: nil)
            hostingController.removeFromParent()
            return
        }

        hostingController.willMove(toParent: parentViewController)
        parentViewController?.addChild(hostingController)
        newSuperview.addSubview(hostingController.view)
        setUpConstraints(to: newSuperview)
        hostingController.didMove(toParent: parentViewController)
    }

    private func setUpConstraints(to view: UIView?) {
        guard let view = view else {
            resetConstraints()
            return
        }

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func resetConstraints() {
        hostingController.view.removeFromSuperview()
    }
}

@available(iOS 13.0, *)
extension SwiftUIContainerView: NavigationControllerProvider {
    public var navigationController: UINavigationController? {
        parentViewController?.navigationController
    }
}

