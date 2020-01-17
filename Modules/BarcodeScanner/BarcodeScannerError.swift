import Foundation

public enum BarcodeScannerError: Error {
    case videoCapturingNotAuthorized
    case videoCapturingConfigurationFailed
    case deviceLockingForConfigurationFailed
    case runtimeError(Error)
}
