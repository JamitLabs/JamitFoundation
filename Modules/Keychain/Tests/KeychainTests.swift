@testable import Keychain
import XCTest

class KeychainTests: XCTestCase {
    let key: String = "jamitFoundation.userDefaults.Tests.sampleKey"
    let mockKeychain: MockKeychain = .init()

    override func tearDown() {
        super.tearDown()

        mockKeychain.clear()
    }

    func testSaveItem() {
        var item: Secured<String?> = .init(key: key, keychain: mockKeychain as KeychainProtocol)
        item.wrappedValue = "Hello World"

        guard
            let keychainData = mockKeychain.attributes[kSecValueData as String] as? Data,
            let securedValue = try? JSONDecoder().decode(String.self, from: keychainData)
        else { return XCTFail() }

        XCTAssertEqual(securedValue, "Hello World")
    }

    func testSaveItemDifferentGroup() {
        let groupID = "my.access.group"
        var item: Secured<String?> = .init(key: key, accessGroup: groupID, keychain: mockKeychain as KeychainProtocol)

        XCTAssertEqual(mockKeychain.query[kSecAttrAccessGroup as String] as? String, groupID)

        item.wrappedValue = "Hello World"
        // The query should have been set correctly during updating of the value as well
        XCTAssertEqual(mockKeychain.query[kSecAttrAccessGroup as String] as? String, groupID)

        guard
            let keychainData = mockKeychain.attributes[kSecValueData as String] as? Data,
            let securedValue = try? JSONDecoder().decode(String.self, from: keychainData)
        else { return XCTFail() }

        // The read data should be correct
        XCTAssertEqual(securedValue, "Hello World")
    }
}
