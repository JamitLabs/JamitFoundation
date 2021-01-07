import Foundation

/// Type that encapsulates the status code and query result
public struct KeychainResult {
    public let status: OSStatus
    public let queryResult: Any?

    public init(status: OSStatus, queryResult: Any?) {
        self.status = status
        self.queryResult = queryResult
    }
}
