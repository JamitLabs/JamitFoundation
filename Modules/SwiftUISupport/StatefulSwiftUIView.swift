import Foundation
import JamitFoundation
import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct StatefulSwiftUIView<ContentView: StatefulViewProtocol>: UIViewRepresentable {
    @Binding private(set) var model: ContentView.Model

    init(
        model: Binding<ContentView.Model> = .constant(.default)
    ) {
        _model = model
    }

    func makeUIView(context: Context) -> ContentView {
        return ContentView.instantiate()
    }

    func updateUIView(_ view: ContentView, context: Context) {
        view.model = model
    }
}
