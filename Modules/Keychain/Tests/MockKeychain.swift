import Foundation
import Keychain

final class MockKeychain: KeychainProtocol {
    var osStatus: OSStatus = 0
    var keychainResult = KeychainResult(status: 10, queryResult: nil)
    var query: [String: Any] = [:]
    var attributes: [String: Any] = [:]

    func add(_ dictionary: [String: Any]) -> OSStatus {
        self.query = dictionary

        return osStatus
    }

    func fetch(_ query: [String: Any]) -> KeychainResult {
        self.query = query

        return keychainResult
    }

    func update(_ query: [String: Any], with attributes: [String: Any]) -> OSStatus {
        self.query = query
        self.attributes = attributes

        return osStatus
    }

    func delete(_ query: [String: Any]) -> OSStatus {
        self.query = query

        return osStatus
    }

    func clear() {
        osStatus = 0
        keychainResult = KeychainResult(status: 0, queryResult: nil)
        query = [:]
        attributes = [:]
    }
}
