import Foundation

/// Type that encapsulates the status code and query result
public struct KeychainResult {
    /// The status returned by the `Security` api when performing CRUD operations on the keychain.
    public let status: OSStatus

    /// The query result value returned by the `Security` api when performing CRUD operations on the keychain.
    public let queryResult: Any?

    /// Initializes a `KeychainResult` structure wrapping the api call results of `Security` framework.
    ///
    /// - Parameters:
    ///   - status: The status returned by the `Security` api when performing CRUD operations on the keychain.
    ///   - queryResult: The query result value returned by the `Security` api when performing CRUD operations on the keychain.
    public init(status: OSStatus, queryResult: Any?) {
        self.status = status
        self.queryResult = queryResult
    }
}
