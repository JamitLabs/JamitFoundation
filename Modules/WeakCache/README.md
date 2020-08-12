# WeakCache

WeakCache is a data structure which holds its elements with a weak reference. The objects reference counter is not increased by adding it to this Cache. This is very useful for example implementing observer patterns.

## Usage

The following example is using the `WeakCache` for implementing an observer. The `CoordinatorCounter`is holding a `WeakCache`containing `CoordinatorObserving`. If a `CoordinatorObserving` registers at the `CoordinatorCounter` all observers are notified about the changed count.

```swift
public final class CoordinatorCounter {
    static let shared: CoordinatorCounter = .init()

    let observers: WeakCache<CoordinatorObserving> = .init()

    private init() { /* NOOP */ }

    public func register(_ observer: CoordinatorObserving) {
        guard !observers.contains(observer) else { return }

        observers.append(observer)
        notifyObserverAboutChangedObserverCount()
    }

    public func unregister(_ observer: CoordinatorObserving) {
        observers.remove(observer)
        notifyObserverAboutChangedObserverCount()
    }

    public func notifyObserverAboutChangedObserverCount() {
        observers.all.forEach {
            $0.coordinatorCounter(self, changedCountTo: observers.all.count)
        }
    }
}

public protocol CoordinatorObserving: AnyObject {
    func coordinatorCounter(_ counter: CoordinatorCounter, changedCountTo count: Int)
}

public extension CoordinatorObserving {
    func coordinatorCounter(_ counter: CoordinatorCounter, changedCountTo count: Int) { /* NOOP */ }
}

```


