// Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import SwiftUI
import SwiftUISupport

struct CandyButton: View {
    let action: () -> Void
    @State private var isActive: Bool = false
    @EnvironmentObject var navigationCoordinator: NavigationCoordinator

    var body: some View {
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
    }
}

struct CandyButton_Previews: PreviewProvider {
    static var previews: some View {
        CandyButton {
            // NOOP
        }
    }
}

