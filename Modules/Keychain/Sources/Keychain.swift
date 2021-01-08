import Foundation

public final class Keychain: KeychainProtocol {
    /// Returns the shared defaults object.
    public static let `default`: Keychain = .init()

    private init() { }

    public func add(_ dictionary: [String : Any]) -> OSStatus {
        SecItemAdd(dictionary as CFDictionary, nil)
    }

    public func fetch(_ query: [String : Any]) -> Keychain {
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        return .init(status: status, queryResult: queryResult)
    }

    public func update(_ query: [String : Any], with attributes: [String : Any]) -> OSStatus {
        SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
    }

    public func delete(_ query: [String : Any]) -> OSStatus {
        SecItemDelete(query as CFDictionary)
    }
}
