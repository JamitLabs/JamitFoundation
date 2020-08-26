// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation

///
/// `WeakCache` is a DataStructure based on `NSHashTable`. The reference counter of the stored elements is not
/// increased by adding it to the `WeakCache`.
/// If the element is deinitialized it is automatically removed from the cache.
///
/// Example:
///
/// ```swift
/// let cache: WeakCache<UIViewController> = .init()
///
/// cache.append(someViewController)
/// ```
///
public final class WeakCache<Element: AnyObject> {
    private let elements: NSHashTable<AnyObject>

    /// All elements of the cache
    public var all: [Element] {
        return elements.allObjects.compactMap { $0 as? Element }
    }

    public init() {
        elements = NSHashTable<AnyObject>.weakObjects()
    }

    /// Appends a new element to the cache
    ///
    /// - parameters:
    ///     - element: The element to append
    public func append(_ element: Element) {
        elements.add(element)
    }

    /// Removes an element from the cache
    ///
    /// - parameters:
    ///     - element: The element to remove
    public func remove(_ element: Element) {
        elements.remove(element)
    }

    /// Checks if the element is stored in the `WeakCache`
    ///
    /// - parameters:
    ///     - element: The element to check
    /// - returns: `true` if the given element is in the cache, `false` if not
    public func contains(_ element: Element) -> Bool {
        return elements.contains(element)
    }

    /// Removes all elements from the cache
    public func removeAll() {
        return elements.removeAllObjects()
    }
}
