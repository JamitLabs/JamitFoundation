// Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import SwiftUI

struct CandyButton: View {
    let action: () -> Void
    @State private var isActive: Bool = false
    @EnvironmentObject var navigationCoordinator: NavigationCoordinator

    var body: some View {
//        NavigationView {
        VStack {
            Button("Hit me 2") {
                navigationCoordinator.push(EmptyView())
            }
            NavigationLink(
                destination: EmptyView(),
                isActive: $isActive
            ) {
                Button("Hit me") {
                    isActive.toggle()
                }
            }
        }

//        }
    }
}

struct CandyButton_Previews: PreviewProvider {
    static var previews: some View {
        CandyButton {
            // NOOP
        }
    }
}

class NavigationCoordinator: ObservableObject {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func push<Content: View>(_ view: Content) {
        let viewController = UIHostingController(rootView: view)

        navigationController?.pushViewController(viewController, animated: true)
    }
}
