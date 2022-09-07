// Copyright © 2022 Jamit Labs GmbH. All rights reserved.

import SwiftUI

struct CandyButton: View {
    let action: () -> Void

    var body: some View {
        Button("This is a SwiftUIButton", action: action)
            .padding()
            .foregroundColor(Color.white)
            .background(Color.purple)
            .cornerRadius(8)
    }
}

struct CandyButton_Previews: PreviewProvider {
    static var previews: some View {
        CandyButton {
            // NOOP
        }
    }
}
