// Copyright © 2024 Jamit Labs GmbH. All rights reserved.

import Foundation

enum KeychainError: Error, LocalizedError {
    case itemNotFound
    case accessError(status: String)
    case decodingError(error: Error)
    case encodingError(error: Error)
    case saveItemToKeychain(status: String)
    case deleteItem

    var errorDescription: String? {
        switch self {
        case .itemNotFound: return "The requested item could not be found in the keychain"
        case .accessError: return "The keychain item could not be accessed"
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
