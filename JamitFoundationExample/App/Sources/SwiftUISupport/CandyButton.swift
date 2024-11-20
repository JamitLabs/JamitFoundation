// Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import SwiftUI
import SwiftUISupport

struct CandyButton: View {
    let action: () -> Void
    @State private var isActive: Bool = false

    var body: some View {
        VStack {
            UIKitNavigationLink(
                destination: EmptyView()
            ) {
                Text("Hit me 2")
            }

            NavigationLink(
                destination: EmptyView()
            ) {
                Text("Hit me 3")
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

