import Foundation

/// A protocol that encapsulates the keychain CRUD operations
public protocol KeychainProtocol {
    /// Adds one or more items to the keychain that match the provided dictionary
    ///
    /// - Parameter dictionary: A dictionary containing an item class specification and optional entries specifying the item's attribute values
    /// - Returns: A result code. See "Security Error Codes" (SecBase.h).
    func add(_ dictionary: [String: Any]) -> OSStatus

    /// Returns one or more items which match a search query.
    ///
    /// - Parameter query: A dictionary containing an item class specification and optional attributes for controlling the search.
    /// - Returns: A custom type that contains a result code(See "Security Error Codes" (SecBase.h)) and optionally a reference to the found item(s).
    func fetch(_ query: [String: Any]) -> KeychainResult

    /// Modify zero or more items which match a search query.
    ///
    /// - Parameter query: A dictionary containing an item class specification and optional attributes for controlling the search.
    /// - Parameter attributes: A dictionary containing one or more attributes whose values should be set to the ones specified
    /// - Returns: A result code. See "Security Error Codes" (SecBase.h).
    func update(_ query: [String: Any], with attributes: [String: Any]) -> OSStatus

    /// Removes one ore more items to the keychain that match the provided dictionary
    ///
    /// - Parameter query: A dictionary containing an item class specification and optional attributes for controlling the search.
    /// - Returns: A result code. See "Security Error Codes" (SecBase.h).
    func delete(_ query: [String: Any]) -> OSStatus
}
