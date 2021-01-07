import Foundation

///
/// `Secured` is a property wrapper that can be applied to any codable property to store it in the keychain
///
/// Example:
/// ```swift
/// @Secured(key: "keychain.value_key")
/// var value: Bool
/// ```
@propertyWrapper
public struct Secured<Value: Codable> {
    private enum KeychainError: Error, LocalizedError {
        case itemNotFound
        case accessError(status: String)
        case unexpectedData
        case decodingError(error: Error)
        case encodingError(error: Error)
        case saveItemToKeychain(status: String)
        case deleteItem

        var errorDescription: String? {
            switch self {
            case .itemNotFound: return "The requested item could not be found in the keychain"
            case .accessError: return "The keychain item could not be accessed"
            case .unexpectedData: return "The retrieved keychain data type is unexpected"
            case .decodingError: return "The retrieved keychain data could not be decoded"
            case .encodingError: return "The item could not be encoded"
            case .saveItemToKeychain: return "The item could not be saved to the keychain"
            case .deleteItem: return "The item could not be removed from the keychain"
            }
        }

        var failureReason: String? {
            switch self {
            case let .accessError(status: error): return error
            case let .decodingError(error: error): return error.localizedDescription
            case let .encodingError(error: error): return error.localizedDescription
            case let .saveItemToKeychain(status: error): return error
            default: return nil
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .itemNotFound: return "Please make sure that the item exists in the keychain before you try to access it"
            case .deleteItem: return "Please make sure that the item exists in the keychain before you try to delete it"
            default: return nil
            }
        }

        func description(for key: String) -> String {
            var description: String = .init(format: "A keychain error associated with the key: %@ occurred", key)

            if let errorDescription = self.errorDescription {
                description.append(String(format: "\nDescription: %@", errorDescription))
            }

            if let reason = failureReason {
                description.append(String(format: "\nReason: %@", reason))
            }

            if let recoverySuggestion = recoverySuggestion {
                description.append(String(format: "\nRecovery Suggestion: %@", recoverySuggestion))
            }

            return description
        }
    }

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
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key
        ]
    }

    private let key: String
    private let keychain: KeychainProtocol

    /// The default initializer for `Secured`
    ///
    /// - Parameter key: The key associated with storing the value inside the Keychain
    public init(key: String, keychain: KeychainProtocol = Keychain.default) {
        self.key = key
        self.keychain = keychain

        do {
            wrappedValue = try loadValueFromKeychain()
        } catch {
            logError(error)
        }
    }

    private func logError(_ error: Error) {
        guard let keychainError = error as? KeychainError else {
            return NSLog("An unexpected error occurred:\nKey: %@\nError: %@", key, error.localizedDescription)
        }

        NSLog(keychainError.description(for: key))
    }

    private func loadValueFromKeychain() throws -> Value {
        var searchQuery = self.searchQuery
        searchQuery[kSecReturnAttributes as String] = true
        searchQuery[kSecReturnData as String] = true

        let keychainResponse = keychain.fetch(searchQuery)

        guard
            keychainResponse.status != errSecItemNotFound,
            keychainResponse.status == errSecSuccess,
            let item = keychainResponse.queryResult as? [String: Any],
            let data = item[kSecValueData as String] as? Data
        else { throw KeychainError.itemNotFound }

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
            try deleteFromKeychain()
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

        guard status == errSecSuccess else { throw KeychainError.saveItemToKeychain(status: status.description) }
    }

    private func deleteFromKeychain() throws {
        let status = keychain.delete(searchQuery)

        guard
            status == errSecSuccess ||
            status == errSecItemNotFound
        else { throw KeychainError.deleteItem }
    }
}
