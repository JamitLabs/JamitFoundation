import JamitFoundation
import UIKit
import SwiftUI

@available(iOS 13.0, *)
/// Takes a stateful view as a generic type and wraps it into a `UIViewRepresentable`.
/// The stateful views model can be changed by changing the `model` property.
public struct StatefulViewRepresentable<ContentView: StatefulViewProtocol>: UIViewRepresentable {
    /// The current state of the view.
    @Binding private(set) var model: ContentView.Model

    /// Initializes a `StatefulViewRepresentable`
    ///
    /// - Parameter model: The model associated with the stateful view
    public init(
        model: Binding<ContentView.Model> = .constant(.default)
    ) {
        _model = model
    }

    public func makeUIView(context: Context) -> ContentView {
        return ContentView.instantiate()
    }

    public func updateUIView(_ view: ContentView, context: Context) {
        view.model = model
    }
}
