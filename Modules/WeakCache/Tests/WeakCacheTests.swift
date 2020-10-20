// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

@testable import WeakCache
import XCTest

class WeakCacheTests: XCTestCase {

    var cache: WeakCache<CacheableElement>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.cache = .init()
    }

    func testAddingElement() throws {
        let element = CacheableElement()
        let amountCacheElements = cache.all.count

        cache.append(element)

        XCTAssertTrue(cache.all.count == (amountCacheElements + 1))

        let cachedElement = cache.all.first { $0.identifier == element.identifier }
        XCTAssertNotNil(cachedElement)

        XCTAssertTrue(cache.contains(element))
    }

    func testRemovingElement() throws {
        let element = CacheableElement()
        cache.append(element)
        XCTAssertTrue(cache.contains(element))

        cache.remove(element)
        XCTAssertFalse(cache.contains(element))
    }

    func testRemovingAllElements() throws {
        let generatedElements: [CacheableElement] = (0 ..< 10).map { _ in CacheableElement() }
        generatedElements.forEach { cache.append($0) }
        XCTAssertEqual(cache.all.count, 10)
        cache.removeAll()

        XCTAssertEqual(cache.all.count, 0)
    }

    func testElementShouldNotBeReferencedStrong() throws {
        cache.append(CacheableElement())
        XCTAssertTrue(cache.all.isEmpty)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        self.cache.removeAll()
        self.cache = nil
    }
}
