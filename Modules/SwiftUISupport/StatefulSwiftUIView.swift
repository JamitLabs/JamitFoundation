import Foundation
import JamitFoundation
import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct StatefulSwiftUIView<ContentView: StatefulViewProtocol>: UIViewRepresentable {
    @Binding private(set) var model: ContentView.Model

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
