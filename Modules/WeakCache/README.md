# WeakCache

WeakCache is a data structure which holds its elements with a weak reference. The objects reference counter is not increased by adding it to this Cache. This is very useful for example implementing observer patterns.

## Usage

```swift
// Initialize with type you want to store
let viewControllerCache: WeakCache<UIViewController> = .init()

// Object you want to store, make sure a strong reference is hold at some place
let myViewController: MyViewController = .init()

// Add the viewController to the cache
viewControllerCache.append(myViewController)

// To iterate through all elements use `all` property
viewControllerCache.all.forEach { viewController in 
	// Do some stuff
}

// To remove myViewController just call remove
viewControllerCache.remove(myViewController)
 
```


### Common Use Case - The Observer

We often use the `WeakCache` for observer implementations. It is used for storing observers without the need to make thoughts about reference counting and reference cycles.
The following example shows how the observer can be implemented. 

```swift
public final class MySubject {
	static let shared: MySubject = .init()

	let observers: WeakCache<MyObserving> = .init()
	
	private var valueToObserve: String = "SomeValue" {
		didSet {
			notifyObserversAboutValueChange()
		}
	}

	private init() { /* NOOP */ }

   	public func register(_ observer: MyObserving) {
   		guard !observers.contains(observer) else { return }

        observers.append(observer)
        
        // Optional: If you need to provide the actual value directly after registration 
        // just notify this observer
        observer.mySubject(self, didChangeValueTo: valueToObserve)
    }

    public func unregister(_ observer: MyObserving) {
        observers.remove(observer)
    }

    public func notifyObserversAboutValueChange() {
        observers.all.forEach { $0.mySubject(self, didChangeValueTo: valueToObserve) }
    }
}

public protocol MyObserving: AnyObject {
    func mySubject(_ subject: MySubject, didChangeValueTo newValue: String)
}

```


