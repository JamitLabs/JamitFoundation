// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation

public final class WeakCache<Element> {
    private let elements: NSHashTable<AnyObject>

    public var all: [Element] {
        return elements.allObjects.compactMap { $0 as? Element }
    }

    public init() {
        elements = NSHashTable<AnyObject>.weakObjects()
    }

    public func append(_ element: Element) {
        elements.add(element as AnyObject)
    }

    public func remove(_ element: Element) {
        elements.remove(element as AnyObject)
    }

    public func contains(_ element: Element) -> Bool {
        return elements.contains(element as AnyObject)
    }

    public func removeAll() {
        return elements.removeAllObjects()
    }
}
