import JamitFoundation
import SwiftUI

@available(iOS 13.0, *)
public class NavigationCoordinator: ObservableObject {
    private let navigationControllerProvider: NavigationControllerProvider

    init(navigationControllerProvider: NavigationControllerProvider) {
        self.navigationControllerProvider = navigationControllerProvider
    }

    public func push<Content: View>(_ view: Content) {
        let viewController = UIHostingController(rootView: view)

        navigationControllerProvider.navigationController?.pushViewController(viewController, animated: true)
    }
}
