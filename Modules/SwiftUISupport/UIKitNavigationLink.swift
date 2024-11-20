import JamitFoundation
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct UIKitNavigationLink<Label, Destination> : View where Label : View, Destination : View {
    @EnvironmentObject private var navigationCoordinator: NavigationCoordinator

    private let destination: Destination
    private let label: Label

    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }

    public init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }

    @MainActor public var body: some View {
        Button {
            navigationCoordinator.push(destination)
        } label: {
            label
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension UIKitNavigationLink where Label == Text {
    public init(_ titleKey: LocalizedStringKey, @ViewBuilder destination: () -> Destination) {
        self.init(destination: destination) {
            Text(titleKey)
        }
    }

    public init<S>(_ title: S, @ViewBuilder destination: () -> Destination) where S : StringProtocol {
        self.init(destination: destination) {
            Text(title)
        }
    }

    public init(_ titleKey: LocalizedStringKey, destination: Destination) {
        self.init(destination: destination) {
            Text(titleKey)
        }
    }

    public init<S>(_ title: S, destination: Destination) where S : StringProtocol {
        self.init(destination: destination) {
            Text(title)
        }
    }
}
