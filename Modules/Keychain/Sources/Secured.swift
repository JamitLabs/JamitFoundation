import Foundation
import OSLog

/// `Secured` is a property wrapper that can be applied to any codable property to store it in the keychain
///
/// Example:
/// ```swift
/// @Secured(key: "keychain.value_key")
/// var value: Bool
/// ```
@propertyWrapper
public struct Secured<Value: Codable> {
    private let key: String
    private let keychain: KeychainProtocol
    private let accessGroup: String?
    private let defaultValue: Value?

    /// The wrapped value of the property value used to directly access the value
    public var wrappedValue: Value? {
        didSet {
            do {
                try storeValueInKeychain(wrappedValue)
            } catch {
                wrappedValue = oldValue

                logError(error)
            }
        }
    }

    private var searchQuery: [String: Any] {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key
        ]
        if let accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        return query
    }

    /// The default initializer for `Secured`
    ///
    /// - Parameter key: The key associated with storing the value inside the Keychain
    public init(key: String, accessGroup: String? = nil, keychain: KeychainProtocol = Keychain.default, defaultValue: Value? = nil) {
        self.key = key
        self.keychain = keychain
        self.accessGroup = accessGroup
        self.defaultValue = defaultValue

        do {
            if let loadedValue = try loadValueFromKeychain() {
                wrappedValue = loadedValue
            } else {
                // If the item was not found, we may recover by returning the default value (if it was set)
                if let defaultValue {
                    wrappedValue = defaultValue
                } else {
                    throw KeychainError.itemNotFound
                }
            }
        } catch {
            logError(error)
        }
    }

    private func logError(_ error: Error) {
        guard let keychainError = error as? KeychainError else {
            if #available(iOS 10.0, *) {
                os_log("An unexpected error occurred:\nKey: %@\nError: %@", key, error.localizedDescription)
            } else {
                print("An unexpected error occurred:\nKey: %@\nError: %@", key, error.localizedDescription)
            }

            return
        }

        if #available(iOS 10.0, *) {
            os_log("An unexpected error occurred:\nKey: %@", keychainError.description(for: key))
        } else {
            print(keychainError.description(for: key))
        }
    }

    private func loadValueFromKeychain() throws -> Value? {
        var searchQuery = self.searchQuery
        searchQuery[kSecReturnAttributes as String] = true
        searchQuery[kSecReturnData as String] = true

        let keychainResponse = keychain.fetch(searchQuery)

        guard
            keychainResponse.status != errSecItemNotFound,
            keychainResponse.status == errSecSuccess,
            let item = keychainResponse.queryResult as? [String: Any],
            let data = item[kSecValueData as String] as? Data
        else {
            // Item not found
            return nil
        }

        do {
            let value = try JSONDecoder().decode(Value.self, from: data)
            return value
        } catch {
            throw KeychainError.decodingError(error: error)
        }
    }

    private func storeValueInKeychain(_ value: Value?) throws {
        guard let value = value else { return try deleteFromKeychain() }

        let encodedData: Data
        do {
            encodedData = try JSONEncoder().encode(value)
        } catch {
            throw KeychainError.encodingError(error: error)
        }

        let attributes: [String: Any] = [
            kSecValueData as String: encodedData
        ]

        var status = keychain.update(searchQuery, with: attributes)

        if status == errSecItemNotFound {
            let addQuery = searchQuery.merging(attributes) { _, new in new }
            status = keychain.add(addQuery)
        }

        guard status == errSecSuccess else {
            throw KeychainError.saveItemToKeychain(status: status.description)
        }
    }

    private func deleteFromKeychain() throws {
        let status = keychain.delete(searchQuery)

        guard
            status == errSecSuccess ||
            status == errSecItemNotFound
        else {
            throw KeychainError.deleteItem
        }
    }
}
